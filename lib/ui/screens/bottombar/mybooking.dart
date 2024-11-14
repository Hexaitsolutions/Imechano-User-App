// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:imechano/ui/modal/send_notification_admin_modal.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/my%20invoice.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:provider/provider.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  bool isSwitch = true;
  dynamic appModelTheme;
  int selectedindex = 0;
  final _repository = Repository();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
          appBar: WidgetAppBar(
            title: 'My Booking',
            menuItem: 'assets/svg/Menu.svg',
            action: 'assets/svg/shopping-cart.svg',
            action2: 'assets/svg/ball.svg',
          ),
          key: _key,
          drawer: drawerpage(),
          backgroundColor: appModelTheme.darkTheme ? black : Color(0xff70bdf1),
          body: SafeArea(
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48.h,
                      margin: EdgeInsets.only(left: 15.w, right: 5.w),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              "assets/svg/serch.svg",
                            ),
                          ),
                          hintText: 'Search With Booking ID',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Poppins3",
                            color: appModelTheme.darkTheme
                                ? Colors.grey
                                : Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
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
                    margin: EdgeInsets.only(left: 16.w, right: 17.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/Group 8257.svg",
                        ),
                        SizedBox(width: 9.w),
                        Text(
                          "Filters",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontFamily: 'Poppins3'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    height: 48,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedindex = 0;
                            setState(() {});
                          },
                          child: card(
                              "Completed", selectedindex == 0 ? true : false),
                        ),
                        SizedBox(width: 15.w),
                        GestureDetector(
                          onTap: () {
                            selectedindex = 1;
                            setState(() {});
                          },
                          child: card(
                              "Pending", selectedindex == 1 ? true : false),
                        ),
                        SizedBox(width: 15.w),
                        GestureDetector(
                          onTap: () {
                            selectedindex = 2;
                            setState(() {});
                          },
                          child: card(
                              "Canceled", selectedindex == 2 ? true : false),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: appModelTheme.darkTheme
                              ? Color(0xff252525)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0))),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowGlow();
                          return true;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [BookingDatails()],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ]),
          )),
    );
  }

  Widget BookingDatails() {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowGlow();
            return true;
          },
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  height: 278.h,
                  margin: EdgeInsets.all(15),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: appModelTheme.darkTheme
                            ? darkmodeColor
                            : Colors.white,
                        margin: EdgeInsets.only(left: 17.w, top: 16.h),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Car Delivery back",
                          style: TextStyle(
                              fontFamily: "Poppins1", fontSize: 13.sp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 17.w, top: 8.h),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting \nindustry. Lorem Ipsum has been the industry's standard dummy text \never since the 1500s",
                          style: TextStyle(
                              color: appModelTheme.darkTheme
                                  ? Colors.white70
                                  : Colors.black87,
                              fontFamily: "Poppins3",
                              fontSize: 10.sp),
                        ),
                      ),
                      SizedBox(height: 13.h),
                      cardPoint("Takes 4 Hours"),
                      cardPoint("Every 6 Months or 5000 Kms"),
                      cardPoint("Alignemt & Balancing Included"),
                      cardPoint("Wheel Rotation Included"),
                      cardPoint("Wheel Rotation Included"),
                      Spacer(),
                      Container(
                        height: 44.h,
                        width: 344.w,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xe165d456)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                          // padding: EdgeInsets.only(
                          //     left: 15.w, right: 15.w, bottom: 15.h, top: 15.h),
                          // textColor: Colors.white,
                          child: Text(
                            "Please press the Button to Confirm",
                            style: TextStyle(
                                fontFamily: "Poppins3", fontSize: 15.sp),
                          ),
                          // color: Color(0xe165d456),
                          onPressed: () {
                            Get.to(MyInvoice());
                            // onSendNotificationAdminAPI();
                          },
                          // shape: new RoundedRectangleBorder(
                          //   borderRadius: new BorderRadius.circular(10.0),
                          // ),
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      )
                    ],
                  ),
                );
              }),
        ));
  }

  Widget card(String title, bool isselected) {
    return Card(
      elevation: 0,

      //==================================by jenish================================
      //
      color: appModelTheme.darkTheme
          ? isselected
              ? logoBlue
              : Colors.transparent
          : isselected
              ? Colors.white
              : Color(0xff70BDF1),
      // color: appModelTheme.darkTheme ? black : logoBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            width: 1.5,
            color: appModelTheme.darkTheme
                ? isselected
                    ? logoBlue
                    : white
                : white,
          )),
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

  dynamic onSendNotificationAdminAPI() async {
    // show loader
    Loader().showLoader(context);
    final SendNotificationAdminModel isAdmin =
        await _repository.onSendNotificationAdminAPI('title', 'message');

    if (isAdmin.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);
      Get.to(MyInvoice());
    } else {
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isAdmin.message != null ? isAdmin.message! : '');
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
}

Widget cardPoint(String title) {
  return Container(
    margin: EdgeInsets.only(left: 17.w, top: 3.h),
    child: Row(
      children: [
        Image(
            height: 10.h,
            image: AssetImage("assets/icons/My Account/Ellipse 27.png")),
        SizedBox(width: 7.w),
        Text(title, style: TextStyle(fontFamily: 'Poppins3', fontSize: 10))
      ],
    ),
  );
}
