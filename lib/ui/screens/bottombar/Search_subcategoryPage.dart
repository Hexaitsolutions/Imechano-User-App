// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imechano/ui/bloc/item_list_bloc.dart';
import 'package:imechano/ui/modal/item_list_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/my_selection_screen.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:imechano/ui/common/globals.dart' as globals;

import '../../provider/Data1.dart';

class seach_subcategry_page extends StatefulWidget {
  final String id;
  final String categoryId;
  final String categoryName;
  final Data1 data;
  const seach_subcategry_page(
      {Key? key,
      required this.id,
      required this.categoryId,
      required this.categoryName,
      required this.data,
      List<bool>? selected,
      Map? selectedServices})
      : super(key: key);

  @override
  _seach_subcategry_pageState createState() => _seach_subcategry_pageState();
}

class _seach_subcategry_pageState extends State<seach_subcategry_page> {
  TextEditingController _others = TextEditingController();
  int currentCount = 0;
  List itemId = [];
  List itemName = [];
  int total = 0;

  dynamic appModelTheme;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    itemlistBloc.ItemlistSinck(widget.id);
    print('_selected');
    print('_selectedasdkjlsdlkjsdjlasdjlk');
    print("asdkas;jd");
    print(widget.data);
    currentCount = widget.data.counter!;
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushReplacement(context, new MaterialPageRoute(
        //             builder: (BuildContext context) => new HomeScreen(currentCount),
        //          ));
        // Navigator.of(context).pop(_currentCount);
        return true;
      },
      child: Scaffold(
        appBar: WidgetAppBar(
          title: widget.categoryName,
          menuItem: 'assets/svg/Arrow_alt_left.svg',
          action: 'assets/svg/shopping-cart.svg',
          action2: 'assets/svg/ball.svg',
        ),
        backgroundColor: appModelTheme.darkTheme ? black : Color(0xff70bdf1),
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: appModelTheme.darkTheme
                                ? Color(0xff252525)
                                : Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 15.h),
                                  selectedcCard(),
                                  SizedBox(height: 10.h),
                                  Container(
                                    height: 91,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w, right: 20.w, top: 15.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Others",
                                            style: TextStyle(
                                                fontFamily: "Poppins1 ",
                                                fontSize: 15.sp),
                                          ),
                                          Container(
                                            // margin:
                                            //     EdgeInsets.only(left: 20.w, right: 20.w),
                                            child: TextField(
                                              onTap: () {
                                                currentCount = 0;
                                              },
                                              controller: _others,
                                              decoration: InputDecoration(
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                hintText: "Type your query...",
                                                hintStyle: TextStyle(
                                                    fontSize: 11,
                                                    fontFamily: 'Poppins3'),
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
                                  SizedBox(height: 40.h),
                                  SizedBox(height: 10.h)
                                ],
                              ),
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
                                      borderRadius: BorderRadius.circular(10.0),
                                    ))),
                                // padding:
                                //     EdgeInsets.only(top: 15.h, bottom: 15.h),
                                // textColor: Colors.white,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          " $currentCount Service\nSelected",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        margin: EdgeInsets.only(left: 20.w),
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                      ),
                                      Container(
                                          child: Text(
                                        "View Selectionssssss",
                                        style:
                                            TextStyle(fontFamily: "Poppins2"),
                                      ))
                                    ],
                                  ),
                                ),
                                // color: Color(0xff70bdf1),
                                onPressed: () {
                                  print(currentCount);

                                  if (widget.data.selectedService!.isEmpty &&
                                      _others.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please Service Selected Item",
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
                                      Get.to(MySelectionPage(
                                          selectedService:
                                              widget.data.selectedService!,
                                          categoryName: widget.categoryName,
                                          categoryId: widget.categoryId,
                                          currentCount: currentCount));
                                    } else {
                                      currentCount = 0;
                                      widget.data.selectedService = {
                                        "sub_category_id": 1,
                                        "customer_id": PrefObj.preferences!
                                            .get(PrefKeys.USER_ID),
                                        "category_id": widget.categoryId,
                                        "item_id": [999],
                                        "item_name": [_others.text.toString()],
                                        "time_date":
                                            DateFormat('yyyy/MM/dd kk:mm')
                                                .format(DateTime.now()),
                                        "address": "",
                                        "total": total,
                                      };
                                      print(widget.data.selectedService);
                                    }
                                    print("adsfasdfasdf");
                                    print(widget.data.selectedService!);
                                    print(widget.categoryName);
                                    print(widget.categoryId);
                                    print(currentCount);

                                    globals.screenstack++;
                                    Get.to(MySelectionPage(
                                        selectedService:
                                            widget.data.selectedService!,
                                        categoryName: widget.categoryName,
                                        categoryId: widget.categoryId,
                                        currentCount: currentCount));
                                    // print("osama");
                                    // print(widget.data.selectedService!);
                                    // print(widget.categoryId);
                                    // print(widget.categoryName);
                                    // print(currentCount);

                                  }
                                },
                                // shape: new RoundedRectangleBorder(
                                //   borderRadius: new BorderRadius.circular(10.0),
                                // ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectedcCard() {
    return StreamBuilder<ItemListModel>(
        stream: itemlistBloc.ItemListStream,
        builder: (context, AsyncSnapshot<ItemListModel> itemlistsnapshot) {
          if (!itemlistsnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print('itemlistsnapshot');
            print(itemlistsnapshot.data!.data!.length);
          }
          return Column(
            children: [
              SizedBox(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemlistsnapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.data.selected![index] =
                              !widget.data.selected![index];
                          // _selected[index] = !_selected[index];
                          if (index == 0 ||
                              index == 1 ||
                              index == 2 ||
                              index == 3 ||
                              index == 4 ||
                              index == 5 ||
                              index == 6 ||
                              index == 7) {
                            // _selected[index]
                            widget.data.selected![index]
                                ? _increment(
                                    itemlistsnapshot.data!.data![index],
                                  )
                                : _decrement(
                                    itemlistsnapshot.data!.data![index],
                                  );
                          }
                          widget.data.selectedService = {
                            "sub_category_id": itemlistsnapshot
                                .data!.data![index].subCategoryId,
                            "customer_id":
                                PrefObj.preferences!.get(PrefKeys.USER_ID),
                            "category_id": widget.categoryId,
                            "item_id": itemId,
                            "item_name": itemName,
                            "time_date": DateFormat('yyyy/MM/dd kk:mm')
                                .format(DateTime.now()),
                            "address": "",
                            "total": total,
                          };
                          print(widget.data.selectedService);
                        });
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                        alignment: Alignment.centerLeft,
                        height: 54,
                        // width: 354.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: appModelTheme.darkTheme
                                  ? widget.data.selected![index]
                                      ? Color(0xffDEEFFC).withOpacity(0.3)
                                      : darkmodeColor
                                  : widget.data.selected![index]
                                      ? Color(0xffDEEFFC)
                                      : Color(0xfff4f5f7)
                              //  _selected[index]
                              //     ? Color(0xff70BDF1)
                              //     : Color(0xfff4f5f7),
                              ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: appModelTheme.darkTheme
                              ? widget.data.selected![index]
                                  ? Color(0xffDEEFFC).withOpacity(0.3)
                                  : darkmodeColor
                              : widget.data.selected![index]
                                  ? Color(0xffDEEFFC)
                                  : Color(0xfff4f5f7),
                          // _selected[index]
                          //     ? Color(0xffDEEFFC)
                          //     : Color(0xfff4f5f7),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                itemlistsnapshot.data!.data![index].item!,
                              ),
                              Text(
                                itemlistsnapshot.data!.data![index].price!,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  void _increment(ItemListData itemListModel) {
    setState(() {
      currentCount++;
      widget.data.counter = currentCount;
      print("widget.data.counter");
      print(widget.data.counter);
      total = total +
          int.parse(
              itemListModel.price!.isNotEmpty ? itemListModel.price! : '0');
    });

    itemId.add(itemListModel.id);
    itemName.add(itemListModel.item);
  }

  void _decrement(ItemListData itemListModel) {
    setState(() {
      if (currentCount > 0) {
        currentCount--;
        widget.data.counter = currentCount;
        print("widget.data.counter");
        print(widget.data.counter);
        total = total -
            int.parse(
                itemListModel.price!.isNotEmpty ? itemListModel.price! : '0');
      }
    });

    itemId.remove(itemListModel.id);
    itemName.remove(itemListModel.item);
  }
}
