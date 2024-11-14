// ignore_for_file: deprecated_member_use, must_be_immutable, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:provider/provider.dart';
import 'package:imechano/ui/common/globals.dart' as globals;

class MoreServicies extends StatefulWidget {
  String catogoryId;
  MoreServicies(this.catogoryId);

  @override
  _MoreServiciesState createState() => _MoreServiciesState();
}

class _MoreServiciesState extends State<MoreServicies> {
  final List<bool> _selected = List.generate(7, (i) => false);
  bool _isTextFieldEnable = true;
  TextEditingController _others = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _isNavigating = false;

  void sendItemsName(String itemName, itemId) async {
    final uri = Uri.parse(Config.apiurl + "add-other-items");

    dynamic postData = {
      'itemName': itemName,
      'itemId': itemId,
    };
    print(postData.toString());
    final response = await http.post(uri,
        body: json.encode(postData),
        headers: {'content-Type': 'application/json'});

    dynamic responseJson;

    if (response.statusCode == 200) {
      globals.other.add(itemId);
      globals.sselected.add({
        'catogory_name': "Other",
        'selected': List.generate(10, (i) => false)
      });

      globals.cart.add({
        "name": "Other",
        "sub_catogory": "Other",
        "Index": [0],
        "price": "0",
        "ItemName": itemName,
        "itemId": itemId,
        "selected": List.generate(10, (i) => false)
      });

      print("good to go");
      setState(() {
        print("Set");
      });

      globals.currentCount = globals.currentCount + 1;
    } else if (response.statusCode == 404) {
      print("ohoo");
    } else {
      return null;
    }
  }

  dynamic appModelTheme;
  @override
  Widget build(BuildContext context) {
    if (globals.cart.any((item) => item['name'].contains('Other'))) {
      _isTextFieldEnable = false;
    } else {
      _isTextFieldEnable = true;
    }
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      appBar: WidgetAppBar(
        title: getTranslated('Other', context) +
            " " +
            getTranslated('Service', context),
        imageicon: 'assets/svg/Arrow_alt_left.svg',
        action: 'assets/svg/shopping-cart.svg',
        action2: 'assets/svg/ball.svg',
      ),
      backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return true;
        },
        child: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: appModelTheme.darkTheme
                              ? Color(0xff252525)
                              : white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated("other_message", context),
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Poppins1'),
                                ),
                              ),
                              Container(
                                height: 91,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getTranslated("Other", context),
                                        style: TextStyle(
                                            fontFamily: "Poppins1 ",
                                            fontSize: 15),
                                      ),
                                      Container(
                                        child: TextField(
                                          onTap: () {},
                                          controller: _others,
                                          enabled: _isTextFieldEnable,
                                          decoration: InputDecoration(
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            hintText: getTranslated(
                                                'Typeyourquery', context),
                                            hintStyle: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'Poppins3'),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                if (_others.text.isEmpty) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text("Error"),
                                                        content: Text(
                                                            "Please enter something."),
                                                        actions: [
                                                          TextButton(
                                                            child: Text("OK"),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else if (globals.cart.any(
                                                    (item) => item['name']
                                                        .contains('Other'))) {
                                                  print(
                                                      "You have already added");
                                                } else {
                                                  int randomNum =
                                                      Random().nextInt(900000) +
                                                          100000;
                                                  print(_others.text);

                                                  sendItemsName(
                                                      _others.text, randomNum);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content:
                                                        Text("Item Added!"),
                                                    backgroundColor:
                                                        Colors.green,
                                                    behavior: SnackBarBehavior
                                                        .floating, // Set behavior
                                                    margin: EdgeInsets.all(
                                                        20.0), // Set margin

                                                    duration:
                                                        Duration(seconds: 2),
                                                  ));
                                                }
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: appModelTheme.darkTheme
                                      ? darkmodeColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: appModelTheme.darkTheme
                                          ? darkmodeColor
                                          : Color(0xffececec)),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                    left: 20.w, right: 20.w, top: 10.h),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                // height: 58.h,
                                // width: 354.w,
                                margin: EdgeInsets.only(
                                    left: 20.w, right: 20.w, bottom: 20.h),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xff70bdf1)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))),
                                  // padding:
                                  // EdgeInsets.only(top: 15.h, bottom: 15.h),
                                  // textColor: Colors.white,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            globals.currentCount.toString() +
                                                " " +
                                                getTranslated(
                                                    'Selected', context) +
                                                " " +
                                                getTranslated(
                                                    'Service', context),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          margin: EdgeInsets.only(left: 20),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Container(
                                            child: Text(
                                          getTranslated(
                                              'Viewselections', context),
                                          style:
                                              TextStyle(fontFamily: "Poppins2"),
                                        ))
                                      ],
                                    ),
                                  ),
                                  // color: Color(0xff70bdf1),
                                  onPressed: () async {
                                    if (_isNavigating) {
                                      return; // Navigation is already in progress
                                    }
                                    _isNavigating = true;

                                    if (globals.cart.isEmpty &&
                                        _others.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please Select Service or Enter Query",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      if (_others.text.isEmpty ||
                                          _others.text == "") {
                                        globals.screenstack++;
                                      } else {}

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return BottomBarPage(4);
                                        // return MySelectionPage(
                                        //     selectedService:
                                        //         widget.data.selectedService!,
                                        //     categoryName: widget.categoryName,
                                        //     categoryId: widget.categoryId,
                                        //     currentCount: globals.currentCount);
                                      }));

                                      _isNavigating = false; // Reset the flag

                                      // setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
