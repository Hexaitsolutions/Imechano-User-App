// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/booking_list_bloc.dart';
import 'package:imechano/ui/modal/Approvedcharged_model.dart';
import 'package:imechano/ui/modal/accept_pickup_model.dart';
import 'package:imechano/ui/modal/booking_list_model.dart';
import 'package:imechano/ui/modal/otp_verify_model.dart';
import 'package:imechano/ui/modal/reject_booking_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/booking_list_show.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/bottombar/car_checkout.dart';
import 'package:imechano/ui/screens/bottombar/confirmpaydetail.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../bloc/pickup_condition_list_bloc.dart';
import '../../common/globals.dart';
import '../../modal/pickup_conditions_list_model.dart';
import '../../styling/config.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({Key? key, this.data}) : super(key: key);
  final ItemData? data;
  @override
  _MyBookingsPageState createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  bool isSwitch = true;
  bool myvalue = false;
  int selectedindex = 3;
  var userStr;
  int selectTab = 0;
  bool confirmKey = false;
  bool payconfirmKey = false;
  bool cancelorder = false;
  bool isConfirm = false;
  String searchString = "";
  bool showFilter = false;
  bool listHaveData = false;
  String search = "";
  dynamic appModelTheme;
  TabController? _tabController;

  var formatter = new DateFormat('dd/MM/yyyy');
  DateTime fromDate = DateTime(2023, 01, 01);
  DateTime toDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final _repository = Repository();

// Filters

  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2023),
      lastDate: toDate,
    );

    if (picked != null) {
      _date = picked;
      fromDate = _date;
      print("Date");
      print(_date);

      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        bookingListbloc.bookinglistsink(
            PrefObj.preferences!.get(PrefKeys.USER_ID), selectTab.toString(),
            start_date: fromDate.toString(), end_date: toDate.toString());
      }

      setState(() {});
    }
    return _date;
  }

  Future<DateTime> selectToDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: fromDate,
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      _date = picked;
      toDate = _date;
      print("Date");
      print(_date);
      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        bookingListbloc.bookinglistsink(
            PrefObj.preferences!.get(PrefKeys.USER_ID), selectTab.toString(),
            start_date: fromDate.toString(), end_date: toDate.toString());
      }
      setState(() {});
    }
    return _date;
  }

  void _runFilter(String enteredKeyword) {
    print("Search keyword");
    print(enteredKeyword);
    if (enteredKeyword.length > 1) {
      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        bookingListbloc.bookinglistsink(
            PrefObj.preferences!.get(PrefKeys.USER_ID), selectTab.toString());
      }
    } else if (enteredKeyword.length > 1) {
      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        bookingListbloc.bookinglistsink(
            PrefObj.preferences!.get(PrefKeys.USER_ID), selectTab.toString(),
            search: enteredKeyword);
      }
    }

    // Refresh the UI
    setState(() {});
  }

  Repository repository = Repository();

  bool flag = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    _tabController = TabController(length: 4, vsync: this);
    userStr =
        PrefObj.preferences!.containsKey(PrefKeys.USER_DATA) ? true : false;

    _tabController?.animateTo(currentBookingTab);

    bookingListbloc
        .bookinglistsink(PrefObj.preferences!.get(PrefKeys.USER_ID),
            currentBookingTab.toString())
        .then((value) {
      flag = false;
      showFilter = false;
      setState(() {
        selectTab = currentBookingTab;
      });
      log('Approved Booking Value = $value');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onPaused();
        break;
      case AppLifecycleState.paused:
        onInactive();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
  }

  // This function is called whenever the text field changes

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("I m builddddd Shoaib TAriq");
    print(PrefObj.preferences!.get(PrefKeys.CARID));
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return WillPopScope(
      onWillPop: () async {
        if (!Navigator.of(context).canPop()) {
          // If there's no screen in the stack, navigate to home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomBarPage(2)),
          );
          return false; // Return false to prevent the app from closing
        } else {
          return true; // Return true to allow the app to close
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: WidgetAppBar(
            title: getTranslated('MyBookings', context),
            menuItem: 'assets/svg/Menu.svg',
            // action: 'assets/svg/shopping-cart.svg',
            action2: 'assets/svg/ball.svg',
          ),
          drawer: drawerpage(),
          backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
          body: ScreenUtilInit(
            designSize: Size(414, 896),
            builder: () => SafeArea(
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: screenSize!.height * 0.05,
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              search = value;
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                "assets/svg/serch.svg",
                                placeholderBuilder: (context) =>
                                    const SizedBox.shrink(),
                              ),
                            ),
                            hintText:
                                getTranslated('SearchwithBookingID', context),
                            hintStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: "Poppins3",
                                color: appModelTheme.darkTheme
                                    ? Colors.grey
                                    : Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.only(bottom: 2),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenSize!.height * 0.05,
                      margin: appModelTheme.appLocal == Locale("en")
                          ? EdgeInsets.only(right: 10.w)
                          : EdgeInsets.only(left: 10.w),
                      padding: EdgeInsets.fromLTRB(1.w, 8.w, 10.w, 8.w),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                        onTap: () {
                          showFilter = !showFilter;
                          // Refresh the UI
                          setState(() {});
                          print("Container was tapped");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Row(
                            children: [
                              Icon(
                                  showFilter
                                      ? Icons.filter_alt_outlined
                                      : Icons.filter_alt_off_outlined,
                                  color: Colors.black,
                                  size: 20.w),
                              SizedBox(width: 8.w),
                              Text(
                                getTranslated('filter', context),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins3'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (showFilter) ...[
                  // These children are only visible if condition is true
                  SizedBox(height: 15.h),
                  _filterwidget(),
                ],
                SizedBox(height: 15),
                requestTab(),
                SizedBox(height: 15),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(top: 5),
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: appModelTheme.darkTheme
                                ? Color(0xff252525)
                                : white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25.0),
                                topLeft: Radius.circular(25.0))),
                        child: _BookingDetails(),
                      )),
                    ],
                  ),
                ),
              ]),
            ),
          )),
    );
  }

  Widget _filterwidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () async {
                fromDate = await selectDate(context, fromDate, 'toDate');
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(left: 13.w),
                width: 100.w,
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${formatter.format(fromDate)}",
                      style: TextStyle(fontSize: 12, fontFamily: 'Poppins3'),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined, size: 18),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () async {
                toDate = await selectToDate(context, toDate, 'fromDate');

                setState(() {});
              },
              child: Container(
                width: 90.w,
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${formatter.format(toDate)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins3',
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined, size: 18),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          InkWell(
            onTap: () {
              setState(() {
                fromDate = DateTime(2023, 01, 01);
                toDate = DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day);
                searchString = "";

                bookingListbloc
                    .bookinglistsink(PrefObj.preferences!.get(PrefKeys.USER_ID),
                        currentBookingTab.toString())
                    .then((value) {
                  flag = false;
                  showFilter = false;
                  setState(() {
                    selectTab = currentBookingTab;
                  });
                  print('Approved Booking Value = $value');
                });
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Clear "),
                )),
          )
        ],
      ),
    );
  }

  Widget requestTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            height: 35,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.0),
                // color: appModelTheme.darkTheme ? Colors.grey : Colors.white,
                color: appModelTheme.darkTheme ? logoBlue : Colors.white,
                // color: Colors.white,
              ),
              labelColor: appModelTheme.darkTheme ? Colors.white : logoBlue,
              // labelColor: Colors.black,
              labelStyle: TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontFamily: "Poppins3",
              ),
              indicatorPadding: EdgeInsets.only(left: 10),
              labelPadding: EdgeInsets.only(left: 10),
              unselectedLabelColor:
                  appModelTheme.darkTheme ? Colors.white : Colors.grey[100],
              onTap: (index) {
                selectTab = index;
                // selectTab = 3;
                flag = true;
                setState(() {});
                if (selectTab == 0) {
                  currentBookingTab = 0;
                  bookingListbloc
                      .bookinglistsink(
                          PrefObj.preferences!.get(PrefKeys.USER_ID), '0')
                      .then((value) {
                    setState(() {
                      showFilter = false;
                      flag = false;
                    });
                    log('Pending Booking Value = $value');
                  });
                } else if (selectTab == 1) {
                  currentBookingTab = 1;
                  bookingListbloc
                      .bookinglistsink(
                          PrefObj.preferences!.get(PrefKeys.USER_ID), '1')
                      .then((value) {
                    flag = false;
                    showFilter = false;
                    setState(() {});

                    log('Complete Booking Value = $value');
                  });
                } else if (selectTab == 2) {
                  currentBookingTab = 2;
                  bookingListbloc
                      .bookinglistsink(
                          PrefObj.preferences!.get(PrefKeys.USER_ID), '2')
                      .then((value) {
                    flag = false;
                    showFilter = false;
                    setState(() {});

                    log('Canceled Booking Value = $value');
                  });
                } else {
                  currentBookingTab = 3;
                  bookingListbloc
                      .bookinglistsink(
                          PrefObj.preferences!.get(PrefKeys.USER_ID), '3')
                      .then((value) {
                    flag = false;
                    showFilter = false;
                    setState(() {});
                    log('Approved Booking Value = $value');
                  });
                }
              },
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        // color: appModelTheme.darkTheme
                        //     ? Colors.grey
                        //     : Colors.white,
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: Colors.white,
                            width: selectTab == 0 ? 0 : 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        getTranslated("Pending", context),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        getTranslated('Completed', context),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        getTranslated('Canceled', context),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        getTranslated('Approved', context),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Shoaib work here
  Widget _BookingDetails() {
    log('Inside booking details');
    return StreamBuilder<BookingListModel>(
        stream: bookingListbloc.bookingliststream,
        builder:
            (context, AsyncSnapshot<BookingListModel> bookinglistsnapshot) {
          if (!bookinglistsnapshot.hasData) {
            return Center(
              child: bookinglistsnapshot.data == null
                  ? CircularProgressIndicator()
                  : Text(
                      'No Data Found',
                      style: TextStyle(fontFamily: 'Poppins1', fontSize: 12),
                    ),
            );
          }
          return flag
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: bookinglistsnapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return bookinglistsnapshot.data!.data![index].items != null
                        ? bookinglistsnapshot.data!.data![index].bookingId!
                                    .contains(search) ||
                                bookinglistsnapshot.data!.data![index].carName!
                                    .toLowerCase()
                                    .contains(search.toLowerCase()) ||
                                bookinglistsnapshot
                                    .data!.data![index].items![0].item!
                                    .toLowerCase()
                                    .contains(search.toLowerCase())
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 15, top: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: appModelTheme.darkTheme
                                          ? darkmodeColor
                                          : white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 1, color: grayE6E6E5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: appModelTheme.darkTheme
                                              ? Colors.black45
                                              : Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: Offset(0, 3),
                                        ),
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _infoList(
                                          bookinglistsnapshot
                                              .data!.data![index],
                                          bookinglistsnapshot
                                              .data!.data![index].timeDate
                                              .toString()),
                                      _infoButton(bookinglistsnapshot
                                          .data!.data![index])
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                        : SizedBox.shrink();
                  },
                );
        });
  }

  Widget _infoList(ItemData data, String dateTime) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated('bookingid', context) +
                " : " +
                data.bookingId.toString(),
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins1',
            ),
          ),
          SizedBox(height: 10),
          Text(
            getTranslated('car', context) + " : " + data.carName.toString(),
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins1',
            ),
          ),
          SizedBox(height: 10),
          Text(
            getTranslated(data.subcategoryName!.removeAllWhitespace, context),
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins1',
            ),
          ),
          if (data.items!.length > 3)
            for (int i = 0; i < 3; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        color: buttonBlue3b5999,
                        size: 8,
                      ),
                      SizedBox(width: 8),
                      data.items![i].subCategoryId == "10013"
                          ? Text(
                              

                              data.items![i].item!.removeAllWhitespace,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins3',
                              ),
                            )
                          : Text(
                              
                              getTranslated(
                                  data.items![i].item!.removeAllWhitespace,
                                  context),
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins3',
                              ),
                            ),
                    ],
                  ),
                  i == 2
                      ? Text(
                          getTranslated(
                              'TapViewDetailstoseemoredetails', context),
                          style: TextStyle(
                            fontSize: 7,
                            fontFamily: 'Poppins3',
                            color: Colors.red,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
          if (data.items!.length <= 3)
            for (int i = 0; i < data.items!.length; i++)
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: buttonBlue3b5999,
                    size: 8,
                  ),
                  SizedBox(width: 7),
                  data.items![i].subCategoryId == "10013"
                      ? Text(
                          

                          data.items![i].item!.removeAllWhitespace,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Poppins3',
                          ),
                        )
                      : Text(
                          //TODO
                          getTranslated(
                              data.items![i].item!.removeAllWhitespace,
                              context),
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Poppins3',
                          ),
                        ),
                ],
              ),
          SizedBox(height: 5),
          _RatingStar(),
          Text(
            '4.0 Ratings',
            style: TextStyle(
              fontSize: 8,
              fontFamily: "Poppins1",
              color: Color(0xff35C648),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking Time',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'Poppins1',
                      ),
                    ),
                    Text(
                      data.bookingTime!,
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'Poppins1',
                      ),
                    ),
                  ]),
              SizedBox(width: 7),
              Column(
                children: [
                  Container(
                    color: Colors.black45,
                    height: 25,
                    width: 1,
                  )
                ],
              ),
              SizedBox(width: 7),
              Column(
                children: [
                  Text(
                    'Appointment Time',
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'Poppins1',
                    ),
                  ),
                  Text(
                    data.timeDate!,
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'Poppins1',
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoButton(ItemData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 20.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookingListShow(
                            data: data,
                            bookingid: data.bookingId,
                            appointment: data.bookingTime,
                            booking: data.timeDate,
                            carName: data.carName,
                          )));
              // Get.to(
              //   BookingListShow(data: data),
              // );
            },
            child: Container(
              height: 30,
              width: 90.w,
              child: Center(
                child: Text(
                  getTranslated('ViewDetails', context),
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: 'Poppins1',
                    //color: appModelTheme.darkTheme ? white : Colors.black26,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: appModelTheme.darkTheme ? white : Colors.black,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // cancelorder
          //     ? Container(
          //         height: 30,
          //         width: 90.w,
          //         child: Center(
          //           child: Text('Cancel Order',
          //               style: TextStyle(
          //                   fontSize: 9,
          //                   fontFamily: 'Poppins1',
          //                   color: appModelTheme.darkTheme
          //                       ? white
          //                       : Colors.black26)),
          //         ),
          //         decoration: BoxDecoration(
          //           border: Border.all(
          //               color:
          //                   appModelTheme.darkTheme ? white : Colors.black38),
          //           borderRadius: BorderRadius.circular(5),
          //         ),
          //       )
          GestureDetector(
            onTap: () {
              log(currentBookingTab.toString());
              if ((data.status != "2" &&
                  currentBookingTab != 2 &&
                  currentBookingTab != 1)) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Warning"),
                          content: Text("Are you sure to Cancel this booking?"),
                          actions: [
                            new TextButton(
                              child: const Text("Yes"),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await onotpAPI(data.bookingId);
                                await rejectbookingApiCall(data.bookingId!);
                                currentBookingTab = 2;
                                Get.offAll(BottomBarPage(1));
                                // setState(() {
                                //   data.cancelorder = true;
                                // });
                              },
                            ),
                            new TextButton(
                              child: const Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              } else {
                Fluttertoast.showToast(
                    msg: currentBookingTab == 1
                        ? 'Booking completed, cannot be cancelled'
                        : currentBookingTab == 2
                            ? 'Booking already cancelled'
                            : "You can't cancel",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Container(
              height: 30,
              width: 90.w,
              child: Center(
                child: Text(
                  getTranslated("CancelOrder", context),
                  style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'Poppins1',
                      color: appModelTheme.darkTheme ? white : Colors.black),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: appModelTheme.darkTheme ? white : Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          selectTab == 0
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    SizedBox(height: 10),
                    payconfirmKey
                        ? Container(
                            height: 30,
                            width: 90.w,
                            child: Center(
                              child: Text(
                                'Pay Confirmed',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontFamily: 'Poppins1',
                                    color: appModelTheme.darkTheme
                                        ? white
                                        : Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber[200],
                              border: Border.all(
                                  color: appModelTheme.darkTheme
                                      ? white
                                      : Colors.black38),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (currentBookingTab == 2) {
                                Fluttertoast.showToast(
                                    msg: "Booking is already cancelled!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (data.paymentStatus != "1") {
                                // Original
                                // }else if(data.paymentStatus != "") { // Test purpose
                                //showAlert(context, data.bookingId.toString());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckOut(
                                          bookingId: data.bookingId.toString(),
                                          choice: 1)),
                                );
                                // setState(() {
                                //   data.cancelorder = false;
                                //   data.payconfirm = false;
                                //   data.paymentStatus = "1";
                                //   data.confirmedpickup = true;
                                //   selectedindex = 4;
                                // });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "You have already paid!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 90.w,
                              child: Center(
                                child: Text(
                                  getTranslated("PayandConfirm", context),
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontFamily: 'Poppins1',
                                      color: (data.paymentStatus != "1")
                                          ? appModelTheme.darkTheme
                                              ? currentBookingTab == 2
                                                  ? Colors.white
                                                  : Colors.white
                                              : currentBookingTab == 2
                                                  ? Colors.white
                                                  : Colors.white
                                          : appModelTheme.darkTheme
                                              ? white
                                              : Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: (data.paymentStatus != "1")
                                    ? currentBookingTab == 2
                                        ? Colors.grey
                                        : Colors.green[400]
                                    : Colors.grey,
                                border: Border.all(
                                    color: appModelTheme.darkTheme
                                        ? white
                                        : Colors.black38),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                  ],
                ),

          selectTab == 0
              ? Container()
              : Column(
                  children: [
                    SizedBox(height: 10),
                    confirmKey
                        ? Container(
                            height: 30,
                            width: 90.w,
                            child: Center(
                              child: Text(
                                'Confirmed Pickup',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontFamily: 'Poppins1',
                                    color: appModelTheme.darkTheme
                                        ? white
                                        : Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: isConfirm ? Colors.red[300] : Colors.grey,
                              border: Border.all(
                                  color: appModelTheme.darkTheme
                                      ? white
                                      : Colors.black38),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              // viewDetailsDialog(context, data, selectedindex);
                              if (currentBookingTab == 2) {
                                Fluttertoast.showToast(
                                    msg: "Booking is already cancelled!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else if (data.pickupStatus == "3") {
                      

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmPayDetail(
                                              selectedindex: selectedindex,
                                              data: data,
                                            )));

                                // viewDetailsDialog(context, data, selectedindex);
                              } else if (data.pickupStatus == "0") {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Info"),
                                          content: Text(
                                              "Car data is not collected yet. We will notify you to confirm pickup soon."),
                                          actions: [
                                            new TextButton(
                                              child: const Text("Ok"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "You have already confirmed pickup!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 90.w,
                              child: Center(
                                child: Text(
                                  getTranslated('confirmpickup', context),
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontFamily: 'Poppins1',
                                      color: appModelTheme.darkTheme
                                          ? white
                                          : Colors.white),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: (data.pickupStatus == "3")
                                    ? Colors.green[400]
                                    : Colors.grey,
                                border: Border.all(
                                    color: appModelTheme.darkTheme
                                        ? white
                                        : Colors.black38),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                  ],
                ),
          // selectTab == 0
          //     ? Container()
          //     : selectTab == selectedindex
          //         ? Container()
          //         : confirmKey
          //             ? Padding(
          //                 padding: EdgeInsets.only(
          //                   right: 17,
          //                 ),
          //                 child: Container(
          //                   height: 32.h,
          //                   width: 88.w,
          //                   child: Center(
          //                     child: Text(
          //                       'confirmed pickup',
          //                       style: TextStyle(
          //                           fontSize: 10.h,
          //                           fontFamily: 'Poppins1',
          //                           color: appModelTheme.darkTheme
          //                               ? white
          //                               : Colors.white),
          //                     ),
          //                   ),
          //                   decoration: BoxDecoration(
          //                     color: Colors.red[300],
          //                     border: Border.all(
          //                         color: appModelTheme.darkTheme
          //                             ? white
          //                             : Colors.black38),
          //                     borderRadius: BorderRadius.circular(5),
          //                   ),
          //                 ),
          //               )
          //             : GestureDetector(
          //                 onTap: () {
          //                   AcceptPickupcall(data.bookingId.toString());
          //                   setState(() {
          //                     confirmKey = true;
          //                   });
          //                 },
          //                 child: Padding(
          //                   padding: EdgeInsets.only(right: 17),
          //                   child: Container(
          //                     height: 32.h,
          //                     width: 88.w,
          //                     child: Center(
          //                       child: Text(
          //                         ' confirm pickup',
          //                         // confirmKey ? 'confirmed pickup' : 'confirm pickup',
          //                         style: TextStyle(
          //                             fontSize: 10.h,
          //                             fontFamily: 'Poppins1',
          //                             color: appModelTheme.darkTheme
          //                                 ? white
          //                                 : Colors.white),
          //                       ),
          //                     ),
          //                     decoration: BoxDecoration(
          //                       color: Colors.red[300],
          //                       border: Border.all(
          //                           color: appModelTheme.darkTheme
          //                               ? white
          //                               : Colors.black38),
          //                       borderRadius: BorderRadius.circular(5),
          //                     ),
          //                   ),
          //                 ),
          //               )
        ],
      ),
    );
  }

  // Widget _infoButton1(ItemData data) {
  //   return GestureDetector(
  //     onTap: () {
  //       onotpAPI(data.bookingId);
  //       print('Booking Id =  ${data.bookingId}');
  //     },
  //     child: Padding(
  //       padding: EdgeInsets.only(right: 17.w, left: 17.w, bottom: 25),
  //       child: Container(
  //         height: 30,
  //         width: 90.w,
  //         child: Center(
  //           child: Text(
  //             'Cancel Order',
  //             style: TextStyle(
  //                 fontSize: 9,
  //                 fontFamily: 'Poppins1',
  //                 color: appModelTheme.darkTheme ? white : Colors.black38),
  //           ),
  //         ),
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //               color: appModelTheme.darkTheme ? white : Colors.black38),
  //           borderRadius: BorderRadius.circular(5),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  dynamic onotpAPI(String? bookingId) async {
    // show loader
    Loader().showLoader(context);
    final OtpVerifyModel isCancelBooking =
        await repository.onCancelBooking(bookingId!);

    if (isCancelBooking.code == '1') {
      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        bookingListbloc.bookinglistsink(
            PrefObj.preferences!.get(PrefKeys.USER_ID), '0');
      }

      Loader().hideLoader(context);
      showSnackBar(context, isCancelBooking.message ?? 'Booking Cancel');
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isCancelBooking.message ?? 'Something went to wrong');
    }
  }

  rejectbookingApiCall(String bookingId) async {
    Loader().showLoader(context);
    final RejectBookingModel isrejectbooking =
        await _repository.onRejectBookingAPI(bookingId);
    if (isrejectbooking.code != '0') {
      Loader().hideLoader(context);
      snackBar(isrejectbooking.message ?? 'Reject Booking');
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isrejectbooking.message != null ? isrejectbooking.message! : '');
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

  Widget _RatingStar() {
    return RatingBar.builder(
      initialRating: 4,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemSize: 13,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Color(0xff35C648),
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  Widget card(String title, bool isselected) {
    return Card(
      elevation: 0,

      //==================================by jenish================================
      //
      color: isselected ? Colors.white : Color(0xff70BDF1),
      // color: appModelTheme.darkTheme ? black : logoBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(width: 1.5, color: Colors.white)),
      child: new Container(
        alignment: Alignment.center,
        height: 50,
        width: 160,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 13,
              fontFamily: "Poppins3",
              color: isselected ? Colors.black : Colors.white),
        ),
      ),
    );
  }

  Widget _body2() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appModelTheme.darkTheme ? Color(0xff252525) : white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
      child: Center(
          child: Text(
        'Data Not Found',
        style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
      )),
    );
  }

  void onResumed() {
    print("~~~~~~~ resumed");
    _tabController?.animateTo(currentBookingTab);

    bookingListbloc
        .bookinglistsink(PrefObj.preferences!.get(PrefKeys.USER_ID),
            currentBookingTab.toString())
        .then((value) {
      flag = false;
      showFilter = false;
      setState(() {
        // payconfirmKey = true;
        // confirmKey = true;
        // payconfirmKey =true;
        selectTab = currentBookingTab;
      });
      print('Approved Booking Value = $value');
    });
  }

  void onPaused() {
    print("~~~~~~~ onPaused");
  }

  void onInactive() {
    print("~~~~~~~ onInactive");
  }

  void onDetached() {
    print("~~~~~~~ onDetached");
  }

  void viewDetailsDialog(
      BuildContext context, ItemData data, int selectedindex) {
    // final appModel = Provider.of<AppModel>(context, listen: false);
    // appModelTheme = appModel;
    pickupConditionsListBloc
        .pickupConditionsListSink(data.bookingId.toString());

    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Container(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height - 100,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  _cardList(data),
                  SizedBox(height: 15),
                  _delChange(),
                  SizedBox(height: 15),
                  _customDivider(),
                  SizedBox(height: 15),
                  _delTotal(data),
                  SizedBox(
                    height: 15,
                  ),
                  _acceptRejectBox(context, data, selectedindex),
                  SizedBox(height: 15),
                  dynamicBottomCard(),
                  SizedBox(height: 15),
                ],
              ),
            ),
          );
        });
  }
}

Widget _cardList(ItemData data) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: data.items?.length,
    itemBuilder: (context, index) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 26, right: 20, bottom: 15, top: 15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(
                  left: 23,
                ),
                child: Text(
                  data.items![index].item!,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: 'Poppins1',
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 10.sp,
                      color: presenting,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Poppins1',
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '250 Ratings',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Poppins3',
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 7.sp,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Takes 4 Hour',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Poppins3',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 7.sp,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Every 6 Months or 5000 kms',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Poppins3',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 7.sp,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      // ========================by jenish==========================
                      'Alignment & Balancing Included',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Poppins3',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // ========================by jenish==========================
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 7,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      // ========================by jenish==========================
                      'Wheel Rotation Inlcluded',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Poppins3',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 17, top: 15.h),
                child: Text(
                  DateFormat('hh:mm a dd-MM-yy')
                      .format(DateTime.parse(data.updatedAt!)),
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontFamily: 'Poppins1',
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget _delChange() {
  return Padding(
    padding: const EdgeInsets.only(left: 27, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Delivery Charges',
          // ========================by jenish==========================
          style: TextStyle(
            fontSize: 10.sp,
            fontFamily: 'Poppins1',
          ),
        ),
        // ========================by jenish==========================
        Text(
          'KWD',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: 'Poppins2',
            color: red,
          ),
        ),
      ],
    ),
  );
}

Widget _customDivider() {
  return Padding(
    padding: const EdgeInsets.only(
      left: 20,
      right: 20,
    ),
    child: Divider(
        // color: appModelTheme.darkTheme ? white : Colors.black38,
        ),
  );
}

Widget _delTotal(ItemData data) {
  return Padding(
    // ========================by jenish==========================
    padding: const EdgeInsets.only(left: 27, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          // ========================by jenish==========================
          'Total',
          style: TextStyle(
            fontSize: 13.sp,
            fontFamily: 'Poppins1',
          ),
        ),
        Text(
          // ========================by jenish==========================
          // 'KWD ${widget.selectedService['total']}',
          'KWD ${data.total}',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Poppins2',
            color: red,
          ),
        ),
      ],
    ),
  );
}

Widget _acceptRejectBox(
    BuildContext context, ItemData data, int selectedindex) {
  Repository repository = Repository();
  return Padding(
      padding: const EdgeInsets.only(left: 27, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent, // This is what you need!
              ),
              child: Text(
                'Approve',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: 'Poppins2',
                  color: white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                AcceptPickupcall(
                    data.bookingId.toString(), context, repository);
                // setState(() {
                data.confirmedpickup = false;
                // confirmKey = true;
                selectedindex = 4;
                // });
              },
            ),
          ),
          // Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 6.0, right: 6.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey, // This is what you need!
              ),
              child: Text(
                'Reject',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 13.sp, fontFamily: 'Poppins2', color: white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                RejectPickupcall(
                    data.bookingId.toString(), context, repository);
              },
            ),
          ),
          // Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 6.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // This is what you need!
              ),
              child: Text(
                'Close',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 13.sp, fontFamily: 'Poppins2', color: white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ));
}

Widget dynamicBottomCard() {
  return StreamBuilder<PickupConditionsListModel>(
      stream: pickupConditionsListBloc.ConditionsListStream,
      builder: (context,
          AsyncSnapshot<PickupConditionsListModel> conditionsListsnapshort) {
        if (!conditionsListsnapshort.hasData) {
          return Center(
              child: conditionsListsnapshort.data == null
                  ? CircularProgressIndicator()
                  : Text(
                      'No Data Found',
                      style: TextStyle(fontFamily: 'Poppins1', fontSize: 18.sp),
                    ));
        }
        return Container(
          key: UniqueKey(),
          // padding: EdgeInsets.only(top: 5),
          child: NotificationListener<OverscrollIndicatorNotification>(
            // onNotification: (notification) {
            //   notification.disallowGlow();
            //   return true;
            // },
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: conditionsListsnapshort.data!.data!.length,
                // reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        // height: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25.0),
                                topLeft: Radius.circular(25.0))),
                        child: Frontbumber(
                            "${conditionsListsnapshort.data!.data![index].label}",
                            "${conditionsListsnapshort.data!.data![index].carCondition}",
                            "${conditionsListsnapshort.data!.data![index].workNeeded}",
                            "${conditionsListsnapshort.data!.data![index].carImage}"),
                      )
                    ],
                  );
                }),
          ),
        );
      });
}

Widget Frontbumber(
    String label, String carCondition, String workNeeded, String image) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xffa9d7f7)),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10),
          child: Text(
            "$label",
            style: TextStyle(fontFamily: "Poppins1", fontSize: 15.sp),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              carImage(image),
              // carImage(temp == null ? '' : temp!.path.toString()),
              // carImage(temp == null ? '' : temp!.path.toString()),
            ],
          ),
        ),
        Row(
          children: [
            bottomCard(carCondition, workNeeded),
          ],
        )
      ],
    ),
  );
}

Widget carImage(String images) {
  if (images.contains(',')) {
    final split = images.split(',');
    final Map<int, String> values = {
      for (int i = 0; i < split.length; i++) i: split[i]
    };
    var containers = "";

    return Row(children: [
      for (int i = 0; i < values.length - 1; i++)
        Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            Config.imageurl + values[i]!,
            fit: BoxFit.fitWidth,
          ),
        )
    ]);
  } else {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey,
      child: Image.network(
        Config.imageurl + images,
        fit: BoxFit.fitWidth,
      ),
    );
  }
  // return Container(
  //   width: 100,
  //   height: 100,
  //   color: Colors.grey,
  //   child: Image.network(
  //     Config.imageurl+image,
  //     fit: BoxFit.fitWidth,
  //   ),
  // );
}

Widget bottomCard(String carCondition, String workNeeded) {
  return Expanded(
      child: Column(
    children: [
      Material(
        child: Container(
          margin: EdgeInsets.all(10.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Pickup Condition",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text("$carCondition",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
      ),
      Material(
        child: Container(
          margin: EdgeInsets.all(10.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Type of Work Needed",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9.sp, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text("$workNeeded",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
      ),
    ],
  ));
}

Widget cardPoint(String title) {
  return Container(
    margin: EdgeInsets.only(left: 20.w, top: 3.h),
    child: Row(
      children: [
        Image(
            height: 10.h,
            image: AssetImage("assets/icons/My Account/Ellipse 27.png")),
        Text(title)
      ],
    ),
  );
}

void showAlert(BuildContext context, String data) {
  Repository repository = Repository();
  PayConfirmApiCall(String booking_id) async {
    Loader().showLoader(context);
    final ApprovedchargesbycustomerModel ispayconfirm =
        await repository.oncustomerApprovedApi(booking_id);
    if (ispayconfirm.code != '0') {
      Loader().hideLoader(context);
      showSnackBar(context, ispayconfirm.message ?? 'Payments Confirm');
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Thank you"),
                content: Text(
                    "We will contact you to visit and collect data of car before pickup!"),
                actions: [
                  new TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
      // incomingBookingsBloc.onincomingBookSink('0', '', '');
      // onSendNotificationAPI();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          ispayconfirm.message != null ? ispayconfirm.message! : '');
    }
  }

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Payment"),
            content: Text("Payment gateway will appear here."),
            actions: [
              new TextButton(
                child: const Text("Pay"),
                onPressed: () {
                  PayConfirmApiCall(data);

                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}

AcceptPickupcall(
    String booking_id, BuildContext context, Repository repository) async {
  Loader().showLoader(context);
  final AcceptpickuprequestModel ispickrequest =
      await repository.onAcceptPickupApi(booking_id);
  if (ispickrequest.code != '0') {
    Loader().hideLoader(context);
    showSnackBar(
        context, ispickrequest.message ?? '"Pickup Confirmation Accepted"');
    // incomingBookingsBloc.onincomingBookSink('0', '', '');
    // onSendNotificationAPI();
  } else {
    Loader().hideLoader(context);
    showpopDialog(context, 'Error',
        ispickrequest.message != null ? ispickrequest.message! : '');
  }
}

RejectPickupcall(
    String booking_id, BuildContext context, Repository repository) async {
  Loader().showLoader(context);
  final AcceptpickuprequestModel ispickrequest =
      await repository.onRejectPickupApi(booking_id);
  if (ispickrequest.code != '0') {
    Loader().hideLoader(context);
    showSnackBar(
        context, ispickrequest.message ?? '"Pickup Confirmation Rejected"');
    // incomingBookingsBloc.onincomingBookSink('0', '', '');
    // onSendNotificationAPI();
  } else {
    Loader().hideLoader(context);
    showpopDialog(context, 'Error',
        ispickrequest.message != null ? ispickrequest.message! : '');
  }
}
