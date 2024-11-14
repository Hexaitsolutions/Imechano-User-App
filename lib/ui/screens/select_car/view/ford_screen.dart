// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
// import 'dart:math';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/BrandModelList_bloc.dart';
import 'package:imechano/ui/modal/Brand_Model_list_model.dart';
import 'package:imechano/ui/modal/addcar_modelClass.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:provider/provider.dart';

import '../../bottombar/bottom_bar.dart';

class FordScreen extends StatefulWidget {
  final String data;
  final String brand;
  final AddCarType type;
  final Map? carData;
  final String? carId;
  final String? carLogo;
  final Function? callBackFunction;
  const FordScreen(
      {Key? key,
      required this.data,
      required this.type,
      required this.brand,
      this.carData,
      this.carLogo,
      this.callBackFunction,
      this.carId = ''})
      : super(key: key);

  @override
  _FordScreenState createState() => _FordScreenState();
}

class _FordScreenState extends State<FordScreen> {
  var isExpanded = false;

  final GlobalKey<ExpansionTileCardState> cardAB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();

  String carImage = '';

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }

  String modelNameTile = getTranslated('ModelName', Get.context!);
  String CylinerTypeTile = getTranslated('SelectCylinderType', Get.context!);
  String SelectCarYar = getTranslated('SelectModalYear', Get.context!);
  final _repository = Repository();
  bool isPetrol = true;
  String? newValue;
  bool _isDropdownOpen =
      false; // define the boolean to track the state of the dropdown button
  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen =
          !_isDropdownOpen; // toggle the state of the dropdown button
    });
  }

  String idnumber = "1";
  String user_idaaa = "24";
  String modelaaa = "a1";
  String cylinderaaa = "test";
  String mileageaaa = "lalala";
  String model_yearaaa = "2021";
  String plate_numberaaa = "127896";
  String chases_numberaaa = "6778878";

  TextEditingController mileageController = TextEditingController();
  FocusNode mileageFocusNode = FocusNode();

  TextEditingController PlatenumberControler = TextEditingController();
  FocusNode platenumberFocusNode = FocusNode();

  TextEditingController ChesesNumberControler = TextEditingController();
  FocusNode chesesNumberFocusNode = FocusNode();

  var carData;
  dynamic appModelTheme;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    if (PrefObj.preferences!.containsKey(PrefKeys.ADDCARDATA)) {
      carData = json.decode(PrefObj.preferences!.get(PrefKeys.ADDCARDATA));
      log("Cars " + carData.toString());
      if (carData['branId'] == widget.data) {
        carImage = carData['image'] ?? '';
        modelNameTile = carData['model'];
        CylinerTypeTile = carData['cylinder'];
        mileageController.text = carData['mileage'];
        SelectCarYar = carData['model_year'];

        if (carData['plate_number'] != null) {
          PlatenumberControler.text = carData['plate_number'];
        }
        if (carData['chases_number'] != null) {
          ChesesNumberControler.text = carData['chases_number'];
        }
        isPetrol =
            carData['fuelType'].toString().contains('Petrol') ? true : false;
      }
    }
    if (widget.type == AddCarType.edit) {
      carData = widget.carData;
      carImage = carData['image'] ?? '';
      modelNameTile = carData['model'];
      CylinerTypeTile = carData['cylinder'];
      mileageController.text = carData['mileage'];
      SelectCarYar = carData['model_year'];
      if (carData['plate_number'] != null) {
        PlatenumberControler.text = carData['plate_number'];
      }
      if (carData['chases_number'] != null) {
        ChesesNumberControler.text = carData['chases_number'];
      }
      isPetrol =
          carData['fuelType'].toString().contains('Petrol') ? true : false;
    }
    branmodelbloc.brandmodellidtsink(widget.data);
  }

  void onAddCarApi() {
    Map postData = {
      'image': carImage,
      'model': modelNameTile,
      'cylinder': CylinerTypeTile,
      'mileage': mileageController.text,
      'model_year': SelectCarYar,
      'plate_number': PlatenumberControler.text,
      'chases_number': ChesesNumberControler.text,
      'branId': widget.data,
      'fuelType': isPetrol ? "Petrol" : "Diesel",
    };

    PrefObj.preferences!.put(PrefKeys.ADDCARDATA, json.encode(postData));
    log('widget.type is ' +
        widget.type.toString() +
        ' and AddCarType.add is ' +
        AddCarType.add.toString() +
        ', ' +
        AddCarType.home.toString() +
        ', ' +
        AddCarType.edit.toString());
    if (widget.type == AddCarType.add || widget.type == AddCarType.edit) {
      addCarApiCall();
    }
  }

  addCarApiCall() async {
    log('Called addCarApiCall()');
    Loader().showLoader(context);
    if (PrefObj.preferences!.containsKey(PrefKeys.ADDCARDATA)) {
      final carData =
          json.decode(PrefObj.preferences!.get(PrefKeys.ADDCARDATA));

      String str = PrefObj.preferences!.get(PrefKeys.USER_ID).toString();

      final addCarModel isAddcar = await _repository.onaddcarApi(
          widget.carId.toString(),
          PrefObj.preferences!.get(PrefKeys.USER_ID),
          carData['model'],
          carData['cylinder'],
          carData['mileage'],
          carData['model_year'],
          carData['plate_number'],
          carData['chases_number'],
          carData['fuelType'],
          carData['branId'],
          widget.type);

      if (isAddcar.code == '1') {
        print("Status Sucessful");
        // widget.callBackFunction!(true);
        PrefObj.preferences!
            .put(PrefKeys.USER_DATA, json.encode(isAddcar.data));
        PrefObj.preferences!.put(PrefKeys.CARID, isAddcar.data!.id);
        PrefObj.preferences!.put(PrefKeys.CARNAME, isAddcar.data!.model);
        Loader().hideLoader(context);
        snackBar(isAddcar.message.toString());
        PrefObj.preferences!.delete(PrefKeys.ADDCARDATA);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarPage(0),
              //  SelectYourCarScreen(
              //     type: AddCarType.home)
            ));
        // Navig
      } else {
        print("Status Failed");

        showpopDialog(context, 'Error',
            isAddcar.message != null ? isAddcar.message! : '');
        snackBar(isAddcar.message.toString());
      }
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    log('Car image: $carImage');
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => Scaffold(
        backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
        key: scaffoldKey,
        drawer: drawerpage(),
        appBar: WidgetAppBar(
            title: getTranslated('SelectyourCar', context),
            imageicon: 'assets/svg/Arrow_alt_left.svg',
            menuItem: 'assets/svg/Menu.svg',
            action2: 'assets/svg/ball.svg'),
        body: Container(
          padding: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: appModelTheme.darkTheme ? Color(0xff252525) : white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Image.network(
                    widget.carLogo!,
                    height: 50.h,
                    errorBuilder: (context, object, stackTrace) =>
                        Icon(Icons.error),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Text(
                      widget.brand,
                      style: TextStyle(fontFamily: "Poppins2"),
                    ),
                  ),
                  carImage.isEmpty
                      ? SizedBox.shrink()
                      : Image.network(
                          carImage,
                          height: 130.h,
                          errorBuilder: (context, object, stackTrace) =>
                              Icon(Icons.error),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Divider(
                      color: divedercolor,
                      thickness: 0.5,
                      height: 0.5.h,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated('SelectyourFuelType', context),
                        style: TextStyle(fontFamily: "Poppins2"),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            log('back from ford screen 3');
                            isPetrol = true;
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: !isPetrol
                                    ? Colors.transparent
                                    : Color(0xffDEEFFC),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: !isPetrol
                                        ? Colors.black12
                                        : Color(0xff70BDF1))),
                            height: 30.h,
                            width: 120.w,
                            child: Text(
                              getTranslated('Petrol', context),
                              style: TextStyle(
                                  fontSize: 13.sp, fontFamily: "Poppins1"),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            log('back from ford screen 365');
                            isPetrol = false;
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: isPetrol
                                    ? Colors.transparent
                                    : Color(0xffDEEFFC),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: isPetrol
                                        ? Colors.black12
                                        : Color(0xff70BDF1))),
                            height: 30.h,
                            width: 120.w,
                            child: Text(
                              getTranslated('Diesel', context),
                              style: TextStyle(
                                  fontSize: 13.sp, fontFamily: "Poppins1"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Divider(
                      color: divedercolor,
                      thickness: 0.5,
                      height: 0.5.sp,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    getTranslated('MentionFewDetails', context),
                    style: TextStyle(fontFamily: "Poppins1", fontSize: 15),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    child: StreamBuilder<BrandModelList>(
                        stream: branmodelbloc.brandmodelstream,
                        builder: (context,
                            AsyncSnapshot<BrandModelList> brandsnapshort) {
                          if (!brandsnapshort.hasData) {
                            return CircularProgressIndicator();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, bottom: 12),
                            child: SingleChildScrollView(
                              child: ExpansionTileCard(
                                expandedTextColor: Colors.black,
                                shadowColor: Colors.white,
                                key: cardAB,
                                onExpansionChanged: (value) {
                                  setState(() {
                                    print(value);
                                    isExpanded = value;
                                  });
                                },
                                children: [
                                  ListView.builder(
                                    // padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        brandsnapshort.data!.data!.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(brandsnapshort
                                            .data!.data![index].model!),
                                        onTap: () {
                                          log('back from ford screen 481');
                                          cardAB.currentState?.collapse();
                                          setState(() {
                                            modelNameTile = brandsnapshort
                                                .data!.data![index].model!;
                                            carImage = brandsnapshort
                                                .data!.data![index].image!;
                                            isExpanded = false;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ],
                                title: Text(
                                  modelNameTile,
                                  style: TextStyle(fontFamily: "Montserrat1"),
                                ),
                                leading: Icon(
                                  Icons.car_rental_sharp,
                                  color: Colors.blueAccent,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: MediaQuery.removePadding(
                  //     removeTop: true,
                  //     removeBottom: true,
                  //     context: context,
                  //     child: ListView.builder(
                  //       // padding: EdgeInsets.zero,
                  //       shrinkWrap: true,
                  //       itemCount: 1.clamp(0, 1),
                  //       itemBuilder: (context, index) {
                  //         return GestureDetector(
                  //           onTap:
                  //               _toggleDropdown, // callback to toggle the dropdown button
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //                 color: Color(0xfffafafa),
                  //                 borderRadius: BorderRadius.circular(12)),
                  //             height: 80,
                  //             margin: EdgeInsets.only(left: 5.0, right: 5),
                  //             child: Center(
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: DropdownButtonFormField(
                  //                   onTap: _toggleDropdown,
                  //                   iconSize: 0.0,
                  //                   decoration: InputDecoration(
                  //                     focusedBorder: InputBorder.none,
                  //                     enabledBorder: UnderlineInputBorder(
                  //                         borderSide:
                  //                             BorderSide(color: Colors.white)),
                  //                     suffixIcon: Icon(
                  //                       Icons.keyboard_arrow_down,
                  //                       size: 25,
                  //                     ),
                  //                     prefixIcon: Icon(
                  //                       Icons.car_rental_sharp,
                  //                       color: Colors.blueAccent,
                  //                       size: 35,
                  //                     ),
                  //                   ),
                  //                   hint: Text(
                  //                     "  " + modelNameTile,
                  //                     style: TextStyle(
                  //                         fontFamily: "Montserrat1",
                  //                         fontSize: 17),
                  //                   ),
                  //                   items: brandsnapshort.data!.data!.map((e) {
                  //                     return DropdownMenuItem(
                  //                         value: e.model,
                  //                         child: Text(
                  //                           '   ${e.model}',
                  //                           style: TextStyle(fontSize: 9),
                  //                         ));
                  //                   }).toList(),
                  //                   onChanged: (changedvalue) {
                  //                     _toggleDropdown();
                  //                     newValue = changedvalue as String?;
                  //                     setState(() {
                  //                       modelNameTile = brandsnapshort
                  //                           .data!.data![index].model!;
                  //                       carImage = brandsnapshort
                  //                           .data!.data![index].image!;
                  //                       cardAB.currentState?.collapse();
                  //                       setState(() {
                  //                         print(changedvalue);
                  //                         modelNameTile = changedvalue!;
                  //                         print(carImage);
                  //                       });
                  //                     });
                  //                   },
                  //                   value: newValue,
                  //                   isDense:
                  //                       true, // set to true to remove extra padding around the dropdown button
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, bottom: 12),
                    child: ExpansionTileCard(
                      expandedTextColor: Colors.black,
                      shadowColor: Colors.white,
                      key: cardB,
                      onExpansionChanged: (value) {
                        setState(() {
                          print(value);
                          isExpanded = value;
                        });
                      },
                      children: [
                        new ListTile(
                          title: const Text('v2'),
                          onTap: () {
                            log('back from ford screen 481');
                            cardB.currentState?.collapse();
                            setState(() {
                              this.CylinerTypeTile = 'v2';
                              //  expansionTile.currentState.collapse();
                              isExpanded = false;
                            });
                          },
                        ),
                        new ListTile(
                          title: const Text('v4'),
                          onTap: () {
                            log('back from ford screen 493');
                            cardB.currentState?.collapse();
                            setState(() {
                              this.CylinerTypeTile = 'v4';
                            });
                          },
                        ),
                        new ListTile(
                          title: const Text('v6'),
                          onTap: () {
                            cardB.currentState?.collapse();
                            setState(() {
                              this.CylinerTypeTile = 'v6';
                            });
                          },
                        ),
                        new ListTile(
                          title: const Text('v8'),
                          onTap: () {
                            cardB.currentState?.collapse();
                            setState(() {
                              this.CylinerTypeTile = 'v8';
                            });
                          },
                        ),
                      ],
                      title: Text(
                        CylinerTypeTile,
                        style: TextStyle(fontFamily: "Montserrat1"),
                      ),
                      leading: Icon(
                        Icons.car_repair,
                        color: Colors.blueAccent,
                        size: 30.h,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    padding: EdgeInsets.only(bottom: 7, top: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appModelTheme.darkTheme
                          ? darkmodeColor
                          : Color(0XFFF8F8F8),
                    ),
                    child: TextFormField(
                      controller: mileageController,
                      focusNode: mileageFocusNode,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Icon(
                              Icons.speed,
                              color: Colors.blueAccent,
                              size: 30.h,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: getTranslated("Mileage", context),
                          hintStyle: TextStyle(
                              fontFamily: "Montserrat1",
                              color: appModelTheme.darkTheme
                                  ? white
                                  : Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ExpansionTileCard(
                      key: cardC,
                      expandedTextColor: Colors.black,
                      shadowColor: Colors.white,
                      onExpansionChanged: (value) {
                        setState(() {
                          print(value);
                          isExpanded = value;
                        });
                      },
                      children: [
                        modelYearListTile('1990-1992'),
                        modelYearListTile('1993-1995'),
                        modelYearListTile('1996-1998'),
                        modelYearListTile('1999-2001'),
                        modelYearListTile('2002-2004'),
                        modelYearListTile('2005-2007'),
                        modelYearListTile('2008-2010'),
                        modelYearListTile('2011-2013'),
                        modelYearListTile('2014-2016'),
                        modelYearListTile('2017-2019'),
                        modelYearListTile('2020-2022'),
                        modelYearListTile('2023+'),
                      ],
                      title: Text(
                        SelectCarYar,
                        style: TextStyle(fontFamily: "Montserrat1"),
                      ),
                      leading: Icon(
                        Icons.directions_car,
                        color: Colors.blueAccent,
                        size: 30.h,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 7, top: 7),
                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appModelTheme.darkTheme
                          ? darkmodeColor
                          : Color(0XFFF8F8F8),
                    ),
                    child: TextFormField(
                      controller: PlatenumberControler,
                      focusNode: platenumberFocusNode,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(9),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Icon(
                              Icons.numbers,
                              color: Colors.blueAccent,
                              size: 30.h,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: getTranslated('carplateno', context),
                          hintStyle: TextStyle(
                              fontFamily: "Montserrat1",
                              color: appModelTheme.darkTheme
                                  ? white
                                  : Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 7, top: 7),
                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appModelTheme.darkTheme
                          ? darkmodeColor
                          : Color(0XFFF8F8F8),
                    ),
                    child: TextFormField(
                      controller: ChesesNumberControler,
                      focusNode: chesesNumberFocusNode,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18),
                            child: Icon(
                              Icons.numbers,
                              color: Colors.blueAccent,
                              size: 30.h,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: getTranslated("ChasisNo", context),
                          hintStyle: TextStyle(
                              fontFamily: "Montserrat1",
                              color: appModelTheme.darkTheme
                                  ? white
                                  : Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        // print('carData');
                        // print(SelectCarYar);
                        if (modelNameTile != '' &&
                            CylinerTypeTile != '' &&
                            mileageController.text != '' &&
                            SelectCarYar != 'Select Model Year' &&
                            PlatenumberControler.text != '') {
                          onAddCarApi();
                        } else {
                          snackBar(
                              getTranslated('AddAllRequiredData!', context));
                        }
                      },
                      child: SizedBox(
                          width: 310.w,
                          height: 50.h,
                          child: Center(
                              child: Text(
                                  widget.type != AddCarType.edit
                                      ? getTranslated('AddCar', context)
                                      : "Save Car",
                                  style: TextStyle(fontFamily: "Poppins1"))))),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget modelYearListTile(String modelYear) {
    return ListTile(
      title: Text(modelYear),
      onTap: () {
        setState(() {
          cardC.currentState?.collapse();
          this.SelectCarYar = modelYear;
          //  expansionTile.currentState.collapse();
        });
      },
    );
  }
}
