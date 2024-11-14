
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/modal/booking_list_model.dart';
import 'package:imechano/ui/modal/cust_joblist_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/bottombar/job_card_details.dart';
import 'package:imechano/ui/screens/my_account/progress_report_active.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../bloc/customer_job_cards_list_bloc.dart';
import '../../share_preferences/pref_key.dart';
import '../../share_preferences/preference.dart';

class MyJobCard extends StatefulWidget {
  const MyJobCard({Key? key, this.data}) : super(key: key);
  final ItemData? data;
  @override
  _MyJobCardState createState() => _MyJobCardState();
}

class _MyJobCardState extends State<MyJobCard>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  dynamic appModelTheme;
  String search = "";
  String fromdate = DateTime.now().toString().split(' ')[0];
  String fromTime = DateTime.now().toString().split(' ')[1].split('.')[0];
  int selectTab = 0;
  var userStr;
  bool showFilter = false;
  TabController? _tabController;
  bool flag = false;
  var formatter = new DateFormat('dd/MM/yyyy');
  DateTime fromDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime toDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<DateTime> selectDate(
      BuildContext context, DateTime _date, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: toDate,
    );

    if (picked != null) {
      _date = picked;
      fromDate = _date;
      print("Date");
      print(_date);

      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        jobcardsListbloc.jobcardslistsink(
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
        jobcardsListbloc.jobcardslistsink(
            PrefObj.preferences!.get(PrefKeys.USER_ID), selectTab.toString(),
            start_date: fromDate.toString(), end_date: toDate.toString());
      }
      setState(() {});
    }
    return _date;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _tabController = TabController(length: 4, vsync: this);
    userStr =
        PrefObj.preferences!.containsKey(PrefKeys.USER_DATA) ? true : false;
    _tabController?.animateTo(currentJobcardTab);

    jobcardsListbloc
        .jobcardslistsink(PrefObj.preferences!.get(PrefKeys.USER_ID),
            currentJobcardTab.toString())
        .then((value) {
      flag = false;
      showFilter = false;
      setState(() {
        // payconfirmKey = true;
        // confirmKey = true;
        // payconfirmKey =true;
        selectTab = currentJobcardTab;
      });
      print('Approved Booking Value = $value');
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

  void _runFilter(String enteredKeyword) {
    print("Search keyword");
    print(enteredKeyword);
    if (enteredKeyword.length < 2) {
      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        jobcardsListbloc.jobcardslistsink(
            PrefObj.preferences!.get(PrefKeys.USER_ID), selectTab.toString(),
            search: enteredKeyword);
      }
    } else {
      if (PrefObj.preferences!.containsKey(PrefKeys.USER_ID)) {
        jobcardsListbloc.jobcardslistsink(
            PrefObj.preferences!.get(PrefKeys.USER_ID), selectTab.toString(),
            search: enteredKeyword);
      }
    }

    // Refresh the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          drawer: drawerpage(),
          appBar: WidgetAppBar(
            title: getTranslated("jobcarddetails", context),
            menuItem: 'assets/svg/Menu.svg',
            // action: 'assets/svg/shopping-cart.svg',
            action2: 'assets/svg/ball.svg',
          ),
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
                        child: _JobCards(),
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
                flag = true;
                setState(() {});
                if (selectTab == 0) {
                  currentJobcardTab = 0;
                  jobcardsListbloc
                      .jobcardslistsink(
                          PrefObj.preferences!.get(PrefKeys.USER_ID), '0')
                      .then((value) {
                    flag = false;
                    showFilter = false;
                    setState(() {});
                    print(value);
                  });
                } else if (selectTab == 1) {
                  currentJobcardTab = 1;
                  jobcardsListbloc
                      .jobcardslistsink(
                          PrefObj.preferences!.get(PrefKeys.USER_ID), '1')
                      .then((value) {
                    flag = false;
                    showFilter = false;
                    setState(() {});
                    print(value);
                  });
                } else if (selectTab == 2) {
                  currentJobcardTab = 2;
                  jobcardsListbloc
                      .jobcardslistsink(
                          PrefObj.preferences!.get(PrefKeys.USER_ID), '2')
                      .then((value) {
                    flag = false;
                    showFilter = false;
                    setState(() {});
                    print(value);
                  });
                } else {
                  currentJobcardTab = 3;
                  jobcardsListbloc
                      .jobcardslistsink(
                          PrefObj.preferences!.get(PrefKeys.USER_ID), '3')
                      .then((value) {
                    flag = false;
                    showFilter = false;
                    setState(() {});
                    print(value);
                  });
                }
                setState(() {});
              },
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
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
                        getTranslated("Completed", context),
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
                        getTranslated("Canceled", context),
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
                        getTranslated("Approved", context),
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

  Widget _JobCards() {
    return StreamBuilder<CustomerJobListModel>(
        stream: jobcardsListbloc.jobcardsliststream,
        builder: (context,
            AsyncSnapshot<CustomerJobListModel> jobcardslistsnapshot) {
          if (!jobcardslistsnapshot.hasData) {
            return Center(
              child: jobcardslistsnapshot.data == null
                  ? CircularProgressIndicator()
                  : Text(
                      'No Data Found',
                      style: TextStyle(fontFamily: 'Poppins1', fontSize: 14),
                    ),
            );
          }
          return flag
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: jobcardslistsnapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    print("Status");
                    print(jobcardslistsnapshot.data!.data![index].status);
                    return jobcardslistsnapshot.data!.data![index].jobDate !=
                            null
                        ? jobcardslistsnapshot.data!.data![index].bookingId!
                                .contains(search)
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 15, top: 15),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: 170,
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 12),
                                      Row(
                                        children: [
                                          SizedBox(width: 10.w),
                                          carddivider(
                                              getTranslated(
                                                  'customername', context),
                                              jobcardslistsnapshot.data!
                                                  .data![index].customerName!),
                                          Spacer(),
                                          carddivider(
                                              getTranslated('date', context),
                                              jobcardslistsnapshot
                                                          .data!
                                                          .data![index]
                                                          .jobDate !=
                                                      null
                                                  ? jobcardslistsnapshot.data!
                                                      .data![index].jobDate
                                                      .toString()
                                                      .substring(
                                                          0,
                                                          jobcardslistsnapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .jobDate
                                                                  .toString()
                                                                  .length -
                                                              16)
                                                  : fromdate),
                                          Spacer(),
                                          carddivider(
                                              getTranslated('time', context),
                                              jobcardslistsnapshot
                                                          .data!
                                                          .data![index]
                                                          .dateTime !=
                                                      null
                                                  ? jobcardslistsnapshot.data!
                                                      .data![index].dateTime
                                                      .toString()
                                                      .substring(
                                                          10,
                                                          jobcardslistsnapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .jobDate
                                                                  .toString()
                                                                  .length -
                                                              7)
                                                  : fromTime),
                                          SizedBox(width: 10.w),
                                        ],
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 10.w),
                                          // carddivider(
                                          //     "Garage Name", 'suju garage'),
                                          // Spacer(),
                                          carddivider(
                                              getTranslated(
                                                  'bookingid', context),
                                              jobcardslistsnapshot.data!
                                                  .data![index].bookingId!),
                                          Spacer(),

                                          jobcardslistsnapshot.data!
                                                      .data![index].status ==
                                                  "0"
                                              ? carddivider(
                                                  getTranslated(
                                                      'status', context),
                                                  getTranslated(
                                                      'notpaid', context))
                                              : jobcardslistsnapshot
                                                          .data!
                                                          .data![index]
                                                          .status ==
                                                      "2"
                                                  ? carddivider(
                                                      getTranslated(
                                                          'status', context),
                                                      getTranslated(
                                                          'Cancel', context))
                                                  : carddivider(
                                                      getTranslated(
                                                          'status', context),
                                                      getTranslated(
                                                          'paid', context)),
                                          SizedBox(width: 20.w),
                                          Spacer(),
                                          SizedBox(width: 20.w),
                                        ],
                                      ),
                                      Spacer(),
                                      // Container(
                                      //   child: Center(
                                      //     child: Text(getTranslated(
                                      //         'jobcarddetails', context)!),
                                      //   ),
                                      // ),
                                      // Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 10.w),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(logoBlue),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                        side: BorderSide(
                                                            color: logoBlue)))),
                                            // textColor: Colors.white,
                                            // color: logoBlue,
                                            child: Text(
                                              getTranslated(
                                                  'jobcarddetails', context),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyJobCardDetails(
                                                            job_number:
                                                                jobcardslistsnapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .jobNumber!),
                                                  ));
                                            },
                                          ),
                                          SizedBox(width: 10.w),

                                          // add herer

                                          ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor: jobcardslistsnapshot
                                                            .data!
                                                            .data![index]
                                                            .status ==
                                                        "0"
                                                    ? MaterialStateProperty.all<
                                                        Color>(Colors.grey)
                                                    : MaterialStateProperty.all<Color>(
                                                        currentJobcardTab == 2
                                                            ? Color.fromARGB(
                                                                255, 186, 186, 186)
                                                            : Colors.green
                                                                .shade400),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ))),

                                            autofocus: true,
                                            // textColor: Colors.white,
                                            // color: logoBlue,
                                            child: Text(
                                              getTranslated(
                                                "progress",
                                                context,
                                              ),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed:
                                                jobcardslistsnapshot
                                                            .data!
                                                            .data![index]
                                                            .status ==
                                                        "0"
                                                    ? null
                                                    : () {
                                                        currentJobcardTab == 2
                                                            ? null
                                                            : Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ProgressReportActive(
                                                                        job_number: jobcardslistsnapshot
                                                                            .data!
                                                                            .data![index]
                                                                            .jobNumber!)));
                                                      },
                                            // shape: new RoundedRectangleBorder(
                                            //   borderRadius: new BorderRadius.circular(30.0),
                                            // ),
                                          ),
                                          SizedBox(width: 10.w),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()
                        : const SizedBox.shrink();
                  },
                );
        });
  }

  Widget _BookingDetails() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
                color: appModelTheme.darkTheme ? darkmodeColor : white,
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
                SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    carddivider("Customer Name", 'R.K.Vahora'),
                    Spacer(),
                    carddivider("Date", '$fromdate'),
                    Spacer(),
                    carddivider("Time", '$fromTime'),
                    SizedBox(width: 10.w),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    // carddivider("Garage Name", 'ksvema'),
                    Spacer(),
                    carddivider("Booking Id", '125'),
                    Spacer(),
                    carddivider(getTranslated('status', context),
                        getTranslated('paid', context)),
                    SizedBox(width: 10.w),
                  ],
                ),
                Spacer(),
                Container(
                  child: Center(
                    child: Text(getTranslated('jobcarddetails', context)),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 10.w),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(logoBlue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ))),
                      // textColor: Colors.white,
                      // color: logoBlue,
                      child: Text("Job Card Details"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyJobCardDetails(job_number: '1004'),
                            ));
                      },
                      // shape: new RoundedRectangleBorder(
                      //   borderRadius: new BorderRadius.circular(30.0),
                      // ),
                    ),
                    SizedBox(width: 10.w),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(logoBlue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ))),
                      // textColor: Colors.white,
                      // color: logoBlue,
                      child: Text("Progress"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProgressReportActive()));
                      },
                      // shape: new RoundedRectangleBorder(
                      //   borderRadius: new BorderRadius.circular(30.0),
                      // ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  void onResumed() {
    print("~~~~~~~ resumed");
    // _tabController?.animateTo(currentBookingTab);

    jobcardsListbloc.jobcardslistsink(
        PrefObj.preferences!.get(PrefKeys.USER_ID), selectTab.toString());
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
}
