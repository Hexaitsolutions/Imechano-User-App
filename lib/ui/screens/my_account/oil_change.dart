// ignore_for_file: camel_case_types, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/item_list_bloc.dart';
import 'package:imechano/ui/common/globals.dart' as globals;
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/modal/item_list_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/Data1.dart';

class oil_Change extends StatefulWidget {
  final String id;
  final String categoryId;
  final String categoryName;
  final String? mainCatogory; // optional parameter with default value

  final Data1 data;

  oil_Change(
      {Key? key,
      required this.id,
      required this.categoryId,
      required this.categoryName,
      required this.data,
      List<bool>? selected,
      this.mainCatogory = "",
      Map? selectedServices})
      : super(key: key);
  @override
  _oil_ChangeState createState() => _oil_ChangeState();
}

class _oil_ChangeState extends State<oil_Change>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _others = TextEditingController();
  bool get wantKeepAlive => true;

  int currentCount = 0;
  //bool _isNavigating = false;

  int total = 0;
  String subCatogory = "";

  bool _isTextFieldEnable = true;
  List<bool> s = [];
  List<int> indexed = [];

  dynamic appModelTheme;
  @override
  void initState() {
    super.initState();
    itemlistBloc.ItemlistSinck(widget.id);

    print(widget.id);
    print(widget.data);
    print("Sfasafdafa");
    print("asdkas;jd");
    print(widget.data.id);
    currentCount = globals.currentCount;
  }

  String refresh = "good";

  @override
  Widget build(BuildContext context) {
    // log('Main Category: ${widget.mainCatogory}');
    //log('Category name: ${widget.categoryName}');
    globals.sselected.add({
      'catogory_name': widget.categoryName,
      'selected': List.generate(10, (i) => false)
    });

    globals.cart
        .where((item) => item['sub_catogory'] == widget.categoryName)
        .forEach((item) {
      indexed = item['Index'];
      s = item['selected'];
    });

    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      appBar: WidgetAppBar(
        title: getTranslated(widget.categoryName.removeAllWhitespace, context),
        imageicon: 'assets/svg/Arrow_alt_left.svg',
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 15.h),
                                selectedcCard(),
                                SizedBox(height: 60.h),
                              ],
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
                                // EdgeInsets.only(top: 15.h, bottom: 15.h),
                                // textColor: Colors.white,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          globals.currentCount.toString() +
                                              " " +
                                              getTranslated(
                                                  'Selected', context) +
                                              " " +
                                              getTranslated('Service', context),
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        margin: EdgeInsets.only(left: 20.w),
                                      ),
                                      SizedBox(
                                        width: 60.w,
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
                                  // if (_isNavigating) {
                                  //   return; // Navigation is already in progress
                                  // }
                                  // _isNavigating = true;

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
                                      print("We were in this sectgion");
                                      print(widget.data.categoryId);
                                      globals.screenstack++;
                                      // Get.to(MySelectionPage(
                                      //     selectedService:
                                      //         widget.data.selectedService!,
                                      //     categoryName: widget.categoryName,
                                      //     categoryId: widget.categoryId,
                                      //     currentCount:
                                      //         globals.currentCount));
                                    } else {
                                      log("OTHER SELEC");
                                      print(widget.data.selectedService);
                                    }
                                    globals.screenstack++;
                                    // final refresh = await Get.to(
                                    //     MySelectionPage(
                                    //         selectedService:
                                    //             widget.data.selectedService!,
                                    //         categoryName: widget.categoryName,
                                    //         categoryId: widget.categoryId,
                                    //         currentCount:
                                    //             globals.currentCount));
                                    log('Refresh: $refresh');

                                    refresh = await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return BottomBarPage(4);
                                      // return MySelectionPage(
                                      //     selectedService:
                                      //         widget.data.selectedService!,
                                      //     categoryName: widget.categoryName,
                                      //     categoryId: widget.categoryId,
                                      //     currentCount: globals.currentCount);
                                    }));

                                    if (refresh == "refresh") {
                                      setState(() {});
                                    }
                                    // _isNavigating = false; // Reset the flag

                                    // setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ],
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
          } else {}
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: itemlistsnapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      subCatogory =
                          itemlistsnapshot.data!.data![index].subCategoryId!;

                      if (itemlistsnapshot.data!.data![index].item!
                          .contains('Others')) {
                        return const SizedBox.shrink();
                      }
                      String servicePrice =
                          itemlistsnapshot.data!.data![index].price!.isEmpty
                              ? '0'
                              : itemlistsnapshot.data!.data![index].price!;
                      String formattedServicePrice =
                          numberFormat.format(int.tryParse(servicePrice) ?? 0);
                      return GestureDetector(
                        onTap: () {
                          print("seleect");
                          print(widget.data.selectedService!);
                          print("Printing Sleected");

                          setState(() {
                            globals.sselected
                                    .where((item) =>
                                        item['catogory_name'] ==
                                        widget.categoryName)
                                    .toList()[0]['selected'][index] =
                                !globals.sselected
                                    .where((item) =>
                                        item['catogory_name'] ==
                                        widget.categoryName)
                                    .toList()[0]['selected'][index];

                            if (index == 0 ||
                                index == 1 ||
                                index == 2 ||
                                index == 3 ||
                                index == 4 ||
                                index == 5 ||
                                index == 6 ||
                                index == 7 ||
                                index == 8) {
                              globals.sselected
                                      .where((item) =>
                                          item['catogory_name'] ==
                                          widget.categoryName)
                                      .toList()[0]['selected'][index]
                                  ? _increment(
                                      itemlistsnapshot.data!.data![index],
                                      widget.mainCatogory!,
                                      index)
                                  : _decrement(
                                      itemlistsnapshot.data!.data![index],
                                      index);
                            }

                            // print("Cartttt");
                            //print(globals.cart);
                            globals.catogoryName = widget.categoryName;
                            globals.selectedService = {
                              "sub_category_id": itemlistsnapshot
                                  .data!.data![index].subCategoryId,
                              "customer_id":
                                  PrefObj.preferences!.get(PrefKeys.USER_ID),
                              "category_id": widget.categoryId,
                              "item_id": globals.itemId,
                              "item_name": globals.itemName,
                              "time_date": DateFormat('yyyy/MM/dd kk:mm')
                                  .format(DateTime.now()),
                              "address": "",
                              "total": total,
                            };

                            widget.data.selectedService = {
                              "sub_category_id": itemlistsnapshot
                                  .data!.data![index].subCategoryId,
                              "customer_id":
                                  PrefObj.preferences!.get(PrefKeys.USER_ID),
                              "category_id": widget.categoryId,
                              "item_id": globals.itemId,
                              "item_name": globals.itemName,
                              "time_date": DateFormat('yyyy/MM/dd kk:mm')
                                  .format(DateTime.now()),
                              "address": "",
                              "total": total,
                            };
                            // print(widget.data.selectedService);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 10.h),
                          alignment: Alignment.centerLeft,
                          height: 54,
                          // width: 354.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: appModelTheme.darkTheme
                                    ? globals.sselected
                                            .where((item) =>
                                                item['catogory_name'] ==
                                                widget.categoryName)
                                            .toList()[0]['selected'][index]
                                        ? Color(0xffDEEFFC).withOpacity(0.3)
                                        : darkmodeColor
                                    : globals.sselected
                                            .where((item) =>
                                                item['catogory_name'] ==
                                                widget.categoryName)
                                            .toList()[0]['selected'][index]
                                        ? Color(0xffDEEFFC)
                                        : Color(0xfff4f5f7)
                                // _selected[index]
                                // ? Color(0xff70BDF1)
                                // : Color(0xfff4f5f7),
                                ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: appModelTheme.darkTheme
                                ? globals.sselected
                                        .where((item) =>
                                            item['catogory_name'] ==
                                            widget.categoryName)
                                        .toList()[0]['selected'][index]
                                    ? Color(0xffDEEFFC).withOpacity(0.3)
                                    : darkmodeColor
                                : globals.sselected
                                        .where((item) =>
                                            item['catogory_name'] ==
                                            widget.categoryName)
                                        .toList()[0]['selected'][index]
                                    ? Color(0xffDEEFFC)
                                    : Color(0xfff4f5f7),
                            // _selected[index]
                            // ? Color(0xffDEEFFC)
                            // : Color(0xfff4f5f7),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getTranslated(
                                      itemlistsnapshot.data!.data![index].item!
                                          .removeAllWhitespace,
                                      context),
                                ),
                                Text(
                                    getTranslated("qr", context) +
                                        ' $formattedServicePrice',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins2',
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _increment(ItemListData itemListModel, String mainCatogory, int index) {
    setState(() {
      globals.currentCount++;
      widget.data.counter = currentCount;
      print("widget.data.counter");
      print(widget.data.counter);
      total = total +
          int.parse(
              itemListModel.price!.isNotEmpty ? itemListModel.price! : '0');
    });
    indexed.add(index);
    String? itemPrice =
        itemListModel.price!.isEmpty ? '0' : itemListModel.price;
    log('Got item price: $itemPrice');
    globals.cart.add({
      "name": mainCatogory,
      "sub_catogory": widget.categoryName,
      "Index": indexed,
      "ItemName": itemListModel.item,
      "price": itemPrice,
      "itemId": itemListModel.id,
      "selected": List.generate(10, (i) => false)
    });

    //print(globals.cart);
    //print(globals.sselected);
    globals.itemId.add(itemListModel.id);
    globals.itemName.add(itemListModel.item);
  }

  void _decrement(ItemListData itemListModel, int index) {
    log("Inside decrement");
    print(index);
    setState(() {
      if (globals.currentCount > 0) {
        globals.currentCount--;
        widget.data.counter = currentCount;
        print("widget.data.counter");
        print(widget.data.counter);
        total = total -
            int.parse(
                itemListModel.price!.isNotEmpty ? itemListModel.price! : '0');
      }
    });

    print("Shoaib is Printing");
    globals.cart
        .where((element) => element["sub_catogory"] == widget.categoryName)
        .forEach((item) {
      print(item['Index'].remove(index));
    });

    globals.cart = globals.cart
        .where((item) => item['itemId'] != itemListModel.id)
        .toList();

    globals.cart =
        globals.cart.where((item) => item['index'] != index).toList();

    globals.itemId.remove(itemListModel.id);
    globals.itemName.remove(itemListModel.item);
  }
}
