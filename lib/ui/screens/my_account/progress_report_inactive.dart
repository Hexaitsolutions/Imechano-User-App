import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

class ProgressreportInactive extends StatefulWidget {
  const ProgressreportInactive({Key? key}) : super(key: key);

  @override
  _ProgressreportInactiveState createState() => _ProgressreportInactiveState();
}

class _ProgressreportInactiveState extends State<ProgressreportInactive> {
  dynamic appModelTheme;

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'Progress Report',
        menuItem: 'assets/svg/Menu.svg',
        imageicon: 'assets/svg/Arrow_alt_left.svg',
        action: 'assets/svg/shopping-cart.svg',
        action2: 'assets/svg/ball.svg',
      ),
      drawer: drawerpage(),
      backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
      body: SafeArea(
        child: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => Column(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: appModelTheme.darkTheme ? Color(0xff252525) : white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Center(
                          child: Text(
                            'BMW',
                            style: TextStyle(
                                fontSize: 15.sp, fontFamily: "Poppins1"),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/icons/select_car/2021-BMW.png",
                            height: 130.h,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 70, right: 70),
                          child: Image.asset("assets/images/Group 9246.png"),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Oil Filter Change",
                                style: TextStyle(
                                    fontFamily: "poppins13", fontSize: 12.sp),
                              ),
                              Text(
                                "Engine Service",
                                style: TextStyle(
                                    fontFamily: "poppins3", fontSize: 12.sp),
                              ),
                              Text(
                                "Battery Service",
                                style: TextStyle(
                                    fontFamily: "poppins3", fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Divider(
                          color: Color(0xffF4F5F7),
                          thickness: 7,
                          // height: 15,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Service Details',
                            style: TextStyle(
                                fontFamily: "poppins1", fontSize: 17.sp),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text("Engnie",
                              style: TextStyle(
                                  fontSize: 15.sp, fontFamily: "poppins1")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 15,
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.h),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star_outlined,
                                        size: 12.sp,
                                        color: presenting,
                                      ),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins1',
                                          color: presenting,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        '250 Ratings',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins3',
                                          color: appModelTheme.darkTheme
                                              ? Colors.white60
                                              : Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.blue,
                                            size: 5,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            'Takes 4 Hour',
                                            style: TextStyle(
                                              fontFamily: 'Roboto1',
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6),
                                        child: Text(
                                          "KDW 6.000",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontFamily: "poppins3",
                                              fontSize: 10.sp,
                                              color: Color(0xffBFBFBF)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: Colors.blue,
                                            size: 5,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            'Every 6 Months or 5000 kms',
                                            style: TextStyle(
                                              fontFamily: 'Poppins3',
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "KDW 4.000",
                                        style: TextStyle(
                                            fontFamily: "Poppins4",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffED4E46)),
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
                                        size: 5,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Alignment & Balancing Included',
                                        style: TextStyle(
                                          fontFamily: 'Poppins3',
                                          fontSize: 10.sp,
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
                                        size: 5,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Wheel Rotation Inlcluded',
                                        style: TextStyle(
                                          fontFamily: 'Poppins3',
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
