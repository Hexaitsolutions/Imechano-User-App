// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/bloc/booking_invoices_bloc.dart';
import 'package:imechano/ui/bloc/booking_list_bloc.dart';

import 'package:imechano/ui/bloc/list_of_invoices_bloc.dart';
import 'package:imechano/ui/modal/Approvedcharged_model.dart';
import 'package:imechano/ui/modal/accept_pickup_model.dart';
import 'package:imechano/ui/modal/booking_list_model.dart';

import 'package:imechano/ui/modal/invoice_model.dart';
import 'package:imechano/ui/modal/otp_verify_model.dart';

import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/booking_list_show.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/bottombar/confirmpaydetail.dart';
import 'package:imechano/ui/screens/bottombar/invoice_detail.dart';
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

class MyInvoice extends StatefulWidget {
  const MyInvoice({Key? key, this.data}) : super(key: key);
  final ItemData? data;
  @override
  _MyInvoiceState createState() => _MyInvoiceState();
}

class _MyInvoiceState extends State<MyInvoice>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  var formatter = new DateFormat('yyyy/MM/dd');
  DateTime fromDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  DateTime toDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
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

  bool flag = true;
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    _tabController = TabController(length: 4, vsync: this);
    userStr =
        PrefObj.preferences!.containsKey(PrefKeys.USER_DATA) ? true : false;
    currentInvoiceTab = 0;
    _tabController?.animateTo(currentInvoiceTab);
    bookingInvoicesBloc
        .bookinginvoicesink(PrefObj.preferences!.get(PrefKeys.USER_ID),
            formatter.format(fromDate), formatter.format(toDate))
        .then((value) {
      flag = false;
      showFilter = false;
      log('Set flag to true');
      setState(() {});
      log('Pending Booking Value = $value');
    });
  }

  var numberFormat = NumberFormat('#,##0.00', 'en_US');

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       onResumed();
  //       break;
  //     case AppLifecycleState.inactive:
  //       onPaused();
  //       break;
  //     case AppLifecycleState.paused:
  //       onInactive();
  //       break;
  //     case AppLifecycleState.detached:
  //       onDetached();
  //       break;
  //   }
  // }

  // This function is called whenever the text field changes
  var profileData;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    profileData = json.decode(PrefObj.preferences!.get(PrefKeys.PROFILE_DATA));

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
          appBar: WidgetAppBar(
            title: getTranslated('myinvoice', context),
            menuItem: 'assets/svg/Menu.svg',
            home: 'assets/svg/homeicon.svg',
            imageicon: 'assets/svg/Arrow_alt_left.svg',
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
                              ),
                            ),
                            hintText:
                                getTranslated("SearchwithBookingID", context),
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
                                getTranslated("filter", context),
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
                  SizedBox(height: 12),
                  _filterwidget(),
                ],
                SizedBox(height: size.height * 0.02),
                requestTab(),
                SizedBox(height: size.height * 0.02),
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
                        child: selectTab == 0 ? _BookingDetails() : _JobCards(),
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
                margin: EdgeInsets.only(left: 15.w),
                width: 100.w,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${formatter.format(fromDate)}",
                      style: TextStyle(fontSize: 11, fontFamily: 'Poppins3'),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined, size: 14),
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
                height: 30,
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
                        fontSize: 11,
                        fontFamily: 'Poppins3',
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined, size: 14),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }

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
        bookingInvoicesBloc.bookinginvoicesink(
            PrefObj.preferences!.get(PrefKeys.USER_ID),
            formatter.format(fromDate),
            formatter.format(toDate));
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
        bookingInvoicesBloc.bookinginvoicesink(
            PrefObj.preferences!.get(PrefKeys.USER_ID),
            formatter.format(fromDate),
            formatter.format(toDate));
      }
      setState(() {});
    }
    return _date;
  }

  Widget requestTab() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 1, right: 15),
          height: size.height * 0.05,
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

              flag = true;
              setState(() {});
              if (selectTab == 0) {
                currentInvoiceTab = 0;
                bookingInvoicesBloc
                    .bookinginvoicesink(
                        PrefObj.preferences!.get(PrefKeys.USER_ID),
                        formatter.format(fromDate),
                        formatter.format(toDate))
                    .then((value) {
                  flag = false;
                  showFilter = false;
                  setState(() {});
                  log('Pending Booking Value = $value');
                });
              } else if (selectTab == 1) {
                currentInvoiceTab = 1;
                listOfInvoicesBloc
                    .listofinvoicessink(
                        PrefObj.preferences!.get(PrefKeys.USER_ID),
                        '1',
                        formatter.format(fromDate),
                        formatter.format(toDate))
                    .then((value) {
                  flag = false;
                  showFilter = false;
                  setState(() {});
                  print(value);
                });
              } else if (selectTab == 2) {
                currentInvoiceTab = 2;
                listOfInvoicesBloc
                    .listofinvoicessink(
                        PrefObj.preferences!.get(PrefKeys.USER_ID),
                        '2',
                        formatter.format(fromDate),
                        formatter.format(toDate))
                    .then((value) {
                  flag = false;
                  showFilter = false;
                  setState(() {});
                  print(value);
                });
              } else if (selectTab == 3) {
                currentInvoiceTab = 3;
                listOfInvoicesBloc
                    .listofinvoicessink(
                        PrefObj.preferences!.get(PrefKeys.USER_ID),
                        '3',
                        formatter.format(fromDate),
                        formatter.format(toDate))
                    .then((value) {
                  flag = false;
                  showFilter = false;
                  setState(() {});
                  print(value);
                });
              }
            },
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated('Booking', context),
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
                      getTranslated('JobCard', context),
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
                      getTranslated('DeliveryScheduled', context),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                      ),
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
                      getTranslated('DeliveryConfirmed', context),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _JobCards() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<InvoiceModel>(
        stream: listOfInvoicesBloc.listofinvoicesstream,
        builder: (context, snapshot) {
          if (flag)
            return Center(child: CircularProgressIndicator());
          else {
            if (snapshot.hasError) {
              return Center(child: Icon(Icons.error));
            } else {
              List<InvoiceData> invoices = snapshot.data!.data ?? [];
              List<InvoiceData> filteredInvoices = invoices
                  .where((invoice) =>
                      invoice.bookingId.toString().contains(search) ||
                      invoice.car!.carName!
                          .toLowerCase()
                          .contains(search.toLowerCase()) ||
                      invoice.jobDate!.contains(search))
                  .toList();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: filteredInvoices.length,
                itemBuilder: (context, index) {
                  final invoice = filteredInvoices[index];
                  // String deliveryCharges = numberFormat
                  //     .format(double.tryParse(invoice.delieveryCharges!) ?? 0);

                  // String total =
                  //     numberFormat.format(double.tryParse(invoice.total!) ?? 0);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvoiceDetail(
                                  choice: currentInvoiceTab,
                                  jobNo: invoice.jobNumber,
                                  invoiceData: invoice,
                                  showPaymentMethod: currentInvoiceTab == 3)));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, bottom: 15, top: 15),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        // height: 250.h,
                        decoration: BoxDecoration(
                            color:
                                appModelTheme.darkTheme ? darkmodeColor : white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: grayE6E6E5),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(bookinglistsnapshot
                            //     .data!.data![index].jobNo!),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15.0),
                                        topLeft: Radius.circular(15.0)),
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(
                                          "assets/icons/My Vehicle/Group 9252.png"),
                                    )),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(size.width * 0.01),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0)),
                                      image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(
                                            "assets/icons/My Vehicle/Group 9252.png"),
                                      )),
                                  // margin: EdgeInsets.only(
                                  //     left: 10.w, right: 10.w),
                                  child: Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CRNo(invoice.bookingId!.toString()),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              height: size.height * 0.02,
                                              image: AssetImage(
                                                  "assets/icons/splash/logo.png"),
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Powered by Company',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontFamily: "Poppins1"),
                                            )
                                          ],
                                        ),
                                        mobileNumber(),
                                      ],
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getTranslated('CustomerDetails', context),
                                    style: TextStyle(
                                      fontFamily: "Poppins2",
                                      fontSize: 14,
                                    ),
                                  ),
                                  carddivider(getTranslated('date', context),
                                      '${invoice.updatedAt!.substring(0, 10)}'),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  PrefObj.preferences!
                                          .containsKey(PrefKeys.PROFILE_IMG)
                                      ? Center(
                                          child: CircleAvatar(
                                            radius: size.width * 0.07,
                                            backgroundImage: NetworkImage(
                                                PrefObj.preferences!
                                                    .get(PrefKeys.PROFILE_IMG)),
                                          ),
                                        )
                                      : Center(
                                          child: CircleAvatar(
                                            radius: size.width * 0.07,
                                            child: Icon(Icons.person,
                                                size: size.width * 0.1),
                                          ),
                                        ),
                                  Spacer(),
                                  carddivider(getTranslated('Name', context),
                                      profileData['name'].toString()),
                                  Spacer(),
                                  carddivider(getTranslated('EmailId', context),
                                      profileData['email'].toString()),
                                  Spacer(),
                                  carddivider(getTranslated('car', context),
                                      invoice.car!.carName!),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Divider(),
                            Center(
                                child: Text(getTranslated("Service", context))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    //height: 130.h,
                                    child: _infoListJobCards(invoice)),
                              ],
                            ),
                            SizedBox(height: 5),
                            // Divider(),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 27, right: 20),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         getTranslated('deliverycharges', context),
                            //         // ========================by jenish==========================
                            //         style: TextStyle(
                            //           fontSize: 10,
                            //           fontFamily: 'Poppins1',
                            //         ),
                            //       ),
                            //       // ========================by jenish==========================
                            //       Text(
                            //         getTranslated("qr", context) +
                            //             deliveryCharges,
                            //         textAlign: TextAlign.end,
                            //         style: TextStyle(
                            //           fontSize: 13,
                            //           fontFamily: 'Poppins2',
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   // ========================by jenish==========================
                            //   padding:
                            //       const EdgeInsets.only(left: 27, right: 20),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         // ========================by jenish==========================
                            //         getTranslated('Total', context),
                            //         style: TextStyle(
                            //           fontSize: 13,
                            //           fontFamily: 'Poppins1',
                            //         ),
                            //       ),
                            //       Text(
                            //         getTranslated("qr", context) + total,
                            //         textAlign: TextAlign.end,
                            //         style: TextStyle(
                            //           fontSize: 13,
                            //           fontFamily: 'Poppins2',
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        });
  }

  Widget _BookingDetails() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<InvoiceModel>(
        stream: bookingInvoicesBloc.bookinginvoicestream,
        builder: (context, snapshot) {
          if (flag)
            return Center(child: CircularProgressIndicator());
          else {
            if (snapshot.hasError) {
              return Center(child: Icon(Icons.error));
            } else {
              List<InvoiceData> invoices = snapshot.data?.data ?? [];

              List<InvoiceData> filteredInvoices = invoices
                  .where((invoice) =>
                      invoice.bookingId.toString().contains(search) ||
                      invoice.car!.carName!
                          .toLowerCase()
                          .contains(search.toLowerCase()) ||
                      invoice.jobDate!.contains(search))
                  .toList();

              return ListView.builder(
                shrinkWrap: true,
                itemCount: filteredInvoices.length,
                itemBuilder: (context, index) {
                  final invoice = filteredInvoices[index];
                  // String deliveryCharges = numberFormat
                  //     .format(double.tryParse(invoice.delieveryCharges!) ?? 0);
                  // String total =
                  //     numberFormat.format(double.tryParse(invoice.total!) ?? 0);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvoiceDetail(
                                  choice: currentInvoiceTab,
                                  showTables: false,
                                  invoiceData: invoice)));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        // height: 250.h,
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color:
                                appModelTheme.darkTheme ? darkmodeColor : white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: grayE6E6E5),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(size.width * 0.01),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0)),
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: AssetImage(
                                        "assets/icons/My Vehicle/Group 9252.png"),
                                  )),
                              // margin: EdgeInsets.only(
                              //     left: 10.w, right: 10.w),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CRNo(invoice.bookingId!.toString()),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          height: size.height * 0.02,
                                          image: AssetImage(
                                              "assets/icons/splash/logo.png"),
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Powered by Company',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontFamily: "Poppins1"),
                                        )
                                      ],
                                    ),
                                    mobileNumber(),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getTranslated('CustomerDetails', context),
                                    style: TextStyle(
                                      fontFamily: "Poppins2",
                                      fontSize: 14,
                                    ),
                                  ),
                                  carddivider(getTranslated('date', context),
                                      '${invoice.updatedAt!.substring(0, 10)}'),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  PrefObj.preferences!
                                          .containsKey(PrefKeys.PROFILE_IMG)
                                      ? Center(
                                          child: CircleAvatar(
                                            radius: size.width * 0.07,
                                            backgroundImage: NetworkImage(
                                                PrefObj.preferences!
                                                    .get(PrefKeys.PROFILE_IMG)),
                                          ),
                                        )
                                      : Center(
                                          child: CircleAvatar(
                                            radius: size.width * 0.07,
                                            child: Icon(Icons.person,
                                                size: size.width * 0.1),
                                          ),
                                        ),
                                  Spacer(),
                                  carddivider(getTranslated('Name', context),
                                      profileData['name'].toString()),
                                  Spacer(),
                                  carddivider(getTranslated('EmailId', context),
                                      profileData['email'].toString()),
                                  Spacer(),
                                  carddivider(getTranslated('car', context),
                                      invoice.car!.carName!),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Divider(),
                            Center(
                                child: Text(
                              getTranslated('Service', context),
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins1',
                              ),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(child: _infoListJobCards(invoice)),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            // Divider(),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 27, right: 20),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         getTranslated('deliverycharges', context),
                            //         // ========================by jenish==========================
                            //         style: TextStyle(
                            //           fontSize: 10,
                            //           fontFamily: 'Poppins1',
                            //         ),
                            //       ),
                            //       // ========================by jenish==========================
                            //       Text(
                            //         getTranslated("qr", context) +
                            //             ' $deliveryCharges',
                            //         textAlign: TextAlign.end,
                            //         style: TextStyle(
                            //           fontSize: 13,
                            //           fontFamily: 'Poppins2',
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   // ========================by jenish==========================
                            //   padding:
                            //       const EdgeInsets.only(left: 27, right: 20),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         // ========================by jenish==========================
                            //         getTranslated('Total', context),
                            //         style: TextStyle(
                            //           fontSize: 13,
                            //           fontFamily: 'Poppins1',
                            //         ),
                            //       ),
                            //       Text(
                            //         // ========================by jenish==========================
                            //         // 'KWD ${widget.selectedService['total']}',
                            //         getTranslated("qr", context) + ' $total',
                            //         textAlign: TextAlign.end,
                            //         style: TextStyle(
                            //           fontSize: 13,
                            //           fontFamily: 'Poppins2',
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        });
  }

  Widget mobileNumber() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Text(
        getTranslated('Telephone', context) + "  .\n+974-55929250",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _infoListJobCards(InvoiceData? invoiceData) {
    return Padding(
      padding: EdgeInsets.only(left: 17, right: 17, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (invoiceData!.subcategoryName != null)
            Text(
              getTranslated(invoiceData.subcategoryName!, context),
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Poppins1',
              ),
            ),
          if (invoiceData.items!.length > 3)
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
                      SizedBox(width: 10.w),
                      invoiceData.items![i].subCategoryId == 10013
                          ? Text(
                              invoiceData
                                  .items![i].itemName!.removeAllWhitespace,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Poppins3',
                              ),
                            )
                          : Text(
                              //TODO
                              getTranslated(
                                  invoiceData
                                      .items![i].itemName!.removeAllWhitespace,
                                  context),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Poppins3',
                              ),
                            ),
                    ],
                  ),
                  i == 2
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Tap View Details to see more details ',
                            style: TextStyle(
                              fontSize: 7,
                              fontFamily: 'Poppins3',
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Text(''),
                ],
              ),
          if (invoiceData.items!.length <= 3)
            for (int i = 0; i < invoiceData.items!.length; i++)
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: buttonBlue3b5999,
                    size: 8,
                  ),
                  SizedBox(width: 10.w),
                  invoiceData.items![i].subCategoryId == 10013
                      ? Text(
                          invoiceData.items![i].itemName!.removeAllWhitespace,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Poppins3',
                          ),
                        )
                      : Text(
                          //TODO
                          getTranslated(
                              invoiceData
                                  .items![i].itemName!.removeAllWhitespace,
                              context),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Poppins3',
                          ),
                        ),
                ],
              ),
        ],
      ),
    );
  }

  Widget CRNo(String bookingID) {
    return Container(
      child: Text(
        getTranslated('bookingid', context) + ":\n$bookingID",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
      margin: EdgeInsets.symmetric(horizontal: screenSize!.width * 0.02),
    );
  }

  Widget JobCardNo(String bookingID) {
    return Container(
      child: Text(
        "JobCard Id:\n$bookingID",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
      margin: EdgeInsets.only(left: 10.w),
    );
  }

  Widget _infoButton1(ItemData data) {
    return GestureDetector(
      onTap: () {
        onotpAPI(data.bookingId);
        print('Booking Id =  ${data.bookingId}');
      },
      child: Padding(
        padding: EdgeInsets.only(right: 17.w, bottom: 25),
        child: Container(
          height: 32.h,
          width: 88.w,
          child: Center(
            child: Text(
              'Cancel Order',
              style: TextStyle(
                  fontSize: 10.h,
                  fontFamily: 'Poppins1',
                  color: appModelTheme.darkTheme ? white : Colors.black26),
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: appModelTheme.darkTheme ? white : Colors.black38),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _infoButton(ItemData data) {
    return Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingListShow(
                        data: data, bookingid: data.bookingId)));
            // Get.to(
            //   BookingListShow(data: data),
            // );
          },
          child: Padding(
            padding: EdgeInsets.only(right: 17.w),
            child: Container(
              height: 32.h,
              width: 88.w,
              child: Center(
                child: Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 10.h,
                    fontFamily: 'Poppins1',
                    color: appModelTheme.darkTheme ? white : Colors.black26,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: appModelTheme.darkTheme ? white : Colors.black38,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        cancelorder
            ? Padding(
                padding: EdgeInsets.only(
                  right: 17.w,
                ),
                child: Container(
                  height: 32.h,
                  width: 88.w,
                  child: Center(
                    child: Text(
                      'Cancel Order',
                      style: TextStyle(
                          fontSize: 10.h,
                          fontFamily: 'Poppins1',
                          color:
                              appModelTheme.darkTheme ? white : Colors.black26),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            appModelTheme.darkTheme ? white : Colors.black38),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  if (data.status != "2" && currentInvoiceTab != 2) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Warning"),
                              content:
                                  Text("Are you sure to Cancel this booking?"),
                              actions: [
                                new TextButton(
                                  child: const Text("Yes"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    onotpAPI(data.bookingId);
                                    setState(() {
                                      data.cancelorder = true;
                                    });
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
                        msg: "You can't cancel",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 17.w,
                  ),
                  child: Container(
                    height: 32.h,
                    width: 88.w,
                    child: Center(
                      child: Text(
                        'Cancel Order',
                        style: TextStyle(
                            fontSize: 10.h,
                            fontFamily: 'Poppins1',
                            color: appModelTheme.darkTheme
                                ? white
                                : Colors.black26),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              appModelTheme.darkTheme ? white : Colors.black38),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
        SizedBox(height: 10.h),
        selectTab == 0
            ? Container()
            : payconfirmKey
                ? Padding(
                    padding: EdgeInsets.only(right: 17),
                    child: Container(
                      height: 32.h,
                      width: 88.w,
                      child: Center(
                        child: Text(
                          'Pay Confirmed',
                          style: TextStyle(
                              fontSize: 10.h,
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
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (currentInvoiceTab == 2) {
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
                        _showAlert(context, data.bookingId.toString());
                        //              Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => PaymentVisa()),
                        // );
                        setState(() {
                          data.cancelorder = false;
                          data.payconfirm = false;
                          data.paymentStatus = "1";
                          data.confirmedpickup = true;
                          selectedindex = 4;
                        });
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
                    child: Padding(
                      padding: EdgeInsets.only(right: 17),
                      child: Container(
                        height: 32.h,
                        width: 88.w,
                        child: Center(
                          child: Text(
                            'Pay and Confirm',
                            style: TextStyle(
                                fontSize: 10.h,
                                fontFamily: 'Poppins1',
                                color: appModelTheme.darkTheme
                                    ? white
                                    : Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: (data.paymentStatus != "1")
                              ? Colors.amber[200]
                              : Colors.grey,
                          border: Border.all(
                              color: appModelTheme.darkTheme
                                  ? white
                                  : Colors.black38),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
        SizedBox(
          height: 10.h,
        ),

        selectTab == 0
            ? Container()
            : confirmKey
                ? Padding(
                    padding: EdgeInsets.only(right: 17),
                    child: Container(
                      height: 32.h,
                      width: 88.w,
                      child: Center(
                        child: Text(
                          'Confirmed Pickup',
                          style: TextStyle(
                              fontSize: 10.h,
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
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      // viewDetailsDialog(context, data, selectedindex);
                      if (currentInvoiceTab == 2) {
                        Fluttertoast.showToast(
                            msg: "Booking is already cancelled!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (data.pickupStatus == "3") {
                        // TODO WORK HERE

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
                    child: Padding(
                      padding: EdgeInsets.only(right: 17),
                      child: Container(
                        height: 32.h,
                        width: 88.w,
                        child: Center(
                          child: Text(
                            'Confirm pickup',
                            style: TextStyle(
                                fontSize: 10.h,
                                fontFamily: 'Poppins1',
                                color: appModelTheme.darkTheme
                                    ? white
                                    : Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: (data.pickupStatus == "3")
                              ? Colors.red[300]
                              : Colors.grey,
                          border: Border.all(
                              color: appModelTheme.darkTheme
                                  ? white
                                  : Colors.black38),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
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
    );
  }

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

  Widget _RatingStar() {
    return RatingBar.builder(
      initialRating: 4,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemSize: 18.sp,
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
        height: 38.h,
        width: 160.w,
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
    _tabController?.animateTo(currentInvoiceTab);

    bookingListbloc
        .bookinglistsink(PrefObj.preferences!.get(PrefKeys.USER_ID),
            currentInvoiceTab.toString())
        .then((value) {
      flag = false;
      showFilter = false;
      setState(() {
        // payconfirmKey = true;
        // confirmKey = true;
        // payconfirmKey =true;
        selectTab = currentInvoiceTab;
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
  return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated('deliverycharges', context),
            // ========================by jenish==========================
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: 'Poppins1',
            ),
          ),
          // ========================by jenish==========================
          Text(
            'QR 0',
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
  });
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
  return Builder(builder: (context) {
    return Padding(
      // ========================by jenish==========================
      padding: const EdgeInsets.only(left: 27, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // ========================by jenish==========================
            getTranslated('total', context),
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
  });
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

void _showAlert(BuildContext context, String data) {
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
      //onSendNotificationAPI();
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
                  print("Pay  Press");

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
