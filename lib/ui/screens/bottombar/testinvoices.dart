// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:provider/provider.dart';

class MyInvoiceTest extends StatefulWidget {
  const MyInvoiceTest({Key? key}) : super(key: key);

  @override
  _MyInvoiceTestState createState() => _MyInvoiceTestState();
}

class _MyInvoiceTestState extends State<MyInvoiceTest> {
  int current_step = 0;
  String startdate = DateTime.now().toString().split(' ')[0];
  String startTime = DateTime.now().toString().split(' ')[1].split('.')[0];

  String fromdate = DateTime.now().toString().split(' ')[0];
  String fromTime = DateTime.now().toString().split(' ')[1].split('.')[0];

  dynamic appModelTheme;

  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;

    return Scaffold(
      appBar: WidgetAppBar(
        title: 'My Invoice',
        menuItem: 'assets/svg/Menu.svg',
        imageicon: 'assets/svg/Arrow_alt_left.svg',
        action2: 'assets/svg/ball.svg',
      ),
      drawer: drawerpage(),
      backgroundColor: appModelTheme.darkTheme ? Color(0xff252525) : white,
      body: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Column(
          children: [
            // appBarWidget(),
            Expanded(
              child: Stack(
                children: [
                  // _blankContainer(),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color:
                              appModelTheme.darkTheme ? darkmodeColor : white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (notification) {
                            notification.disallowGlow();
                            return true;
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 64.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0)),
                                      image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(
                                            "assets/icons/My Vehicle/Group 9252.png"),
                                      )),
                                  margin:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CRNo(),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              height: 30.h,
                                              image: AssetImage(
                                                  "assets/icons/splash/logo.png"),
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Powered by Company',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8.sp,
                                                  fontFamily: "Poppins1"),
                                            )
                                          ],
                                        ),
                                        mobileNumber(),
                                      ],
                                    ),
                                  ),
                                ),
                                schedule(),
                                Divider(
                                    indent: 10.w,
                                    endIndent: 10.w,
                                    color: Colors.grey),
                                SizedBox(height: 8),
                                customerDetails(),
                                Divider(
                                  indent: 10.w,
                                  endIndent: 10.w,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                dataCard(),
                                SizedBox(height: 8),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: Text(
                                          "Car Information",
                                          style:
                                              TextStyle(fontFamily: "Poppins2"),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      carDetails(),
                                      Divider(
                                        indent: 10.w,
                                        endIndent: 10.w,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: Text(
                                          "Parts Repairs-Spares Elimate:",
                                          style: TextStyle(
                                            fontFamily: "Poppins2",
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      table(),
                                      SizedBox(height: 15.h),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: Text(
                                          "Labour Estimates",
                                          style: TextStyle(
                                              fontFamily: "Poppins2",
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      tableSecond(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Date: 24-10-2021",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                fontFamily: "Poppins1"),
                                          ),
                                          totalPart(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      totalLabour(),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      estBalance(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarWidget() {
    return Container(
        height: 70.h,
        color: appModelTheme.darkTheme ? black : logoBlue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "job id : 2564152",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'Poppins2'),
                    ),
                  ),
                  Container(
                    width: 110.w,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ViewDataPage();
                            },
                          ));
                        },
                        child: Text(
                          "View Details",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins1',
                              fontSize: 10),
                        )),
                  ),
                  Container(
                    width: 120.w,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              "Download",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins1',
                                  fontSize: 12.sp),
                            ),
                            // SizedBox(width: 2.w),
                            Icon(
                              Icons.download,
                              color: Colors.white,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _blankContainer() {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: appModelTheme.darkTheme ? black : logoBlue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100.0.w),
            bottomRight: Radius.circular(100.0.w)),
      ),
    );
  }

  Widget table() {
    List partno = [
      '1',
      '2',
      '3',
    ];

    List ptype = [
      'New Org',
      'Used Org',
      'New Org',
    ];

    List pdesc = [
      'Break Liner',
      'Spring Liner',
      'Ball Joint Curk',
    ];

    List qty = [
      '4',
      '2',
      '1',
    ];

    List ecost = [
      '2.000',
      '1.000',
      '4.000',
    ];

    List total = [
      '0.00',
      '0.00',
      '0.00',
    ];
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showBottomBorder: true,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Color(0xff162e3f)),
        // columnSpacing: 18.w,
        dataRowHeight: 55.h,
        horizontalMargin: 10,
        columns: [
          DataColumn(
              label: Text(
                'Part No.',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins1',
                    fontSize: 12.sp),
              ),
              numeric: false),
          DataColumn(
            label: Text('Part Type',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins1',
                    fontSize: 12.sp)),
          ),
          DataColumn(
              label: Text('Part Desc',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins1',
                      fontSize: 12.sp))),
          DataColumn(
              label: Text('Qty',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins1',
                      fontSize: 12.sp))),
          DataColumn(
              label: Text('Est Cost',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins1',
                      fontSize: 12.sp))),
          DataColumn(
              label: Text('Total',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins1',
                      fontSize: 12.sp))),
        ],
        rows: List.generate(3, (index) {
          return DataRow(cells: [
            DataCell(Center(
              child: Text(
                partno[index],
                style: TextStyle(fontFamily: 'Poppins1', fontSize: 11.sp),
              ),
            )),
            DataCell(Center(
              child: Text(
                ptype[index],
                style: TextStyle(fontFamily: 'Poppins1', fontSize: 11.sp),
              ),
            )),
            DataCell(Center(
              child: Text(
                pdesc[index],
                style: TextStyle(fontFamily: 'Poppins1', fontSize: 11.sp),
              ),
            )),
            DataCell(Center(
              child: Text(
                qty[index],
                style: TextStyle(fontFamily: 'Poppins1', fontSize: 11.sp),
              ),
            )),
            DataCell(Center(
              child: Text(
                ecost[index],
                style: TextStyle(fontFamily: 'Poppins1', fontSize: 11.sp),
              ),
            )),
            DataCell(Center(
              child: Text(
                total[index],
                style: TextStyle(fontFamily: 'Poppins1', fontSize: 11.sp),
              ),
            )),
          ]);
        }),
      ),
    );
  }

  Widget tableSecond() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: DataTable(
        showBottomBorder: true,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Color(0xff162e3f)),
        horizontalMargin: 10,
        dataRowHeight: 55.h,
        columns: [
          DataColumn(
              label: Text('Sr No.',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins1',
                      fontSize: 12.sp)),
              numeric: false),
          DataColumn(
            label: Text('Labour Work Description',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins1',
                    fontSize: 12.sp)),
          ),
          DataColumn(
              label: Text('Total',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins1',
                      fontSize: 12.sp))),
        ],
        rows: List.generate(2, (index) {
          return DataRow(cells: [
            DataCell(
              Center(
                child: Text(
                  '1',
                  style: TextStyle(fontFamily: 'Popp  ins1', fontSize: 11.sp),
                ),
              ),
            ),
            DataCell(Center(
              child: Text(
                'Lorem Ipsum is simply dummy text of the',
                style: TextStyle(fontFamily: 'Poppins1', fontSize: 11.sp),
              ),
            )),
            DataCell(Center(
              child: Text(
                'KWD 2000',
                style: TextStyle(fontFamily: 'Poppins1', fontSize: 11.sp),
              ),
            )),
          ]);
        }),
      ),
    );
  }

  Widget dataCard() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              schedule(),
              SizedBox(height: 5.h),
              Divider(),
              SizedBox(height: 5.h),
              Text(
                "Customer Details",
                style: TextStyle(
                  fontFamily: "Poppins2",
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Image(
                      image:
                          AssetImage("assets/icons/My Vehicle/Group 9254.png"),
                      height: 50.h),
                  Spacer(),
                  carddivider("Name", 'Mustufa Khan'),
                  Spacer(),
                  carddivider("Address", '12, mihjhut'),
                  Spacer(),
                  carddivider("City/State", 'London'),
                ],
              ),
              SizedBox(height: 5.h),
              Divider(),
              SizedBox(height: 5.h),
              Text(
                "Car Information",
                style: TextStyle(fontFamily: "Poppins2", fontSize: 10.sp),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Image(
                      image:
                          AssetImage("assets/icons/My Vehicle/Group 9253.png"),
                      height: 50.h),
                  Spacer(),
                  carddivider("Make", 'Mustufa Khan'),
                  Spacer(),
                  carddivider("Model", 'djytajend'),
                  Spacer(),
                  carddivider("Year", '2021'),
                  Spacer(),
                  carddivider("Mileage", '20kmh'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget schedule() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 5.w),
        carddivider('Order At', '$startTime'),
        Spacer(),
        carddivider('Deleivery At', '2.30AM'),
        Spacer(),
        carddivider('Dete', '$startdate'),
        SizedBox(width: 5.w),
      ],
    );
    // Container(
    //   margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15, bottom: 5),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             "Order At",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           SizedBox(height: 5.h),
    //           Text("${startTime}")
    //         ],
    //       ),
    //       Container(
    //         margin: EdgeInsets.only(left: 10.w),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "Delivery At",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             SizedBox(height: 5.h),
    //             Text("2.30AM")
    //           ],
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             "Date/Time",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           SizedBox(height: 5.h),
    //           Text("${startdate}")
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget CRNo() {
    return Container(
      child: Text(
        "Booking Id.\n1232334654654",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
      margin: EdgeInsets.only(left: 10.w),
    );
  }

  Widget mobileNumber() {
    return Container(
      margin: EdgeInsets.only(
        right: 10.w,
      ),
      child: Text(
        "Telephone No.\n+9125-2543-25",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget customerDetails() {
    return Container(
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Details",
            style: TextStyle(fontFamily: "Poppins2"),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("assets/icons/My Vehicle/Group 9254.png"),
                height: 65.h,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name:",
                            style: TextStyle(
                                fontFamily: "Poppins1", fontSize: 17.sp)),
                        SizedBox(height: 5),
                        Text("Address:",
                            style: TextStyle(
                                fontFamily: "Poppins1", fontSize: 17.sp)),
                        SizedBox(height: 5),
                        Text("City/State:",
                            style: TextStyle(
                                fontFamily: "Poppins1", fontSize: 17.sp))
                      ],
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mustufa Khan",
                            style: TextStyle(
                                fontFamily: "Poppins1", fontSize: 17.sp)),
                        SizedBox(height: 5),
                        Text("dsfgsdfsdfsdfsdf",
                            style: TextStyle(
                                fontFamily: "Poppins1", fontSize: 17.sp)),
                        SizedBox(height: 5),
                        Text("Dubai",
                            style: TextStyle(
                                fontFamily: "Poppins1", fontSize: 17.sp))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  Widget carDetails() {
    return Container(
      margin: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage("assets/icons/My Vehicle/Group 9253.png"),
            height: 65.h,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Make:",
                        style:
                            TextStyle(fontFamily: "Poppins1", fontSize: 17.sp)),
                    SizedBox(height: 5),
                    Text("Model:",
                        style:
                            TextStyle(fontFamily: "Poppins1", fontSize: 17.sp)),
                    SizedBox(height: 5),
                    Text("Year:",
                        style:
                            TextStyle(fontFamily: "Poppins1", fontSize: 17.sp)),
                    SizedBox(height: 5),
                    Text("Mileage:",
                        style:
                            TextStyle(fontFamily: "Poppins1", fontSize: 17.sp))
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mustufa Khan",
                        style:
                            TextStyle(fontFamily: "Poppins1", fontSize: 17.sp)),
                    SizedBox(height: 5),
                    Text("dsfgsdfsdfsdfsdf",
                        style:
                            TextStyle(fontFamily: "Poppins1", fontSize: 17.sp)),
                    SizedBox(height: 5),
                    Text("2021",
                        style:
                            TextStyle(fontFamily: "Poppins1", fontSize: 17.sp)),
                    SizedBox(height: 5),
                    Text("20 KMH",
                        style:
                            TextStyle(fontFamily: "Poppins1", fontSize: 17.sp))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget estBalance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 40.h,
          width: 200.w,
          //padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
          alignment: Alignment.center,
          color:
              appModelTheme.darkTheme ? Color(0xff252525) : Color(0xffdde2f5),
          child: Text(
            "Est Balance: KWD 2.000",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
          ),
        ),
      ],
    );
  }

  Widget totalLabour() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 40.h,
          width: 200.w,
          //padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
          alignment: Alignment.center,
          color:
              appModelTheme.darkTheme ? Color(0xff252525) : Color(0xffdde2f5),
          child: Text(
            "Total Labour: KWD 10.000",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
          ),
        ),
      ],
    );
  }

  Widget totalPart() {
    return Container(
      height: 40.h,
      width: 200.w,
      //padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
      alignment: Alignment.center,
      color: appModelTheme.darkTheme ? Color(0xff252525) : Color(0xffdde2f5),
      child: Text(
        "Total Part: KWD 10.00",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Poppins2", fontSize: 13.sp),
      ),
    );
  }
}

class ViewDataPage extends StatefulWidget {
  const ViewDataPage({Key? key}) : super(key: key);

  @override
  State<ViewDataPage> createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  List buttonName = [
    'View Details',
    'Cancel Order',
    'Pay and Confirmation',
    'Cofirm Pickup'
  ];
  dynamic appModelTheme;
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'View Details',
        menuItem: 'assets/svg/Menu.svg',
        imageicon: 'assets/svg/Arrow_alt_left.svg',
        action2: 'assets/svg/ball.svg',
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Container(
              height: 225.h,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: 130.h, child: _infoList()),
                      Column(children: [
                        SizedBox(height: 10),
                        _infoButton1(buttonName[0]),
                        _infoButton1(buttonName[1]),
                        _infoButton1(buttonName[2]),
                        _infoButton1(buttonName[3]),
                      ]),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 17),
                    child: _RatingStar(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      '4.0 Ratings',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: "Poppins1",
                        color: Color(0xff35C648),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        },
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

  Widget appBarWidget() {
    return Container(
        height: 70.h,
        color: appModelTheme.darkTheme ? black : logoBlue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "job id : 2564152",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'Poppins2'),
                    ),
                  ),
                  Container(
                    width: 110.w,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ViewDataPage();
                            },
                          ));
                        },
                        child: Text(
                          "View Details",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins1',
                              fontSize: 10),
                        )),
                  ),
                  Container(
                    width: 120.w,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              "Download",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins1',
                                  fontSize: 12.sp),
                            ),
                            // SizedBox(width: 2.w),
                            Icon(
                              Icons.download,
                              color: Colors.white,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _blankContainer() {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: appModelTheme.darkTheme ? black : logoBlue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100.0.w),
            bottomRight: Radius.circular(100.0.w)),
      ),
    );
  }

  Widget _infoList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 17, top: 15.h),
          child: Text(
            'Maushaun Gupta',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'Poppins1',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 17, top: 9),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: buttonBlue3b5999,
                size: 8,
              ),
              SizedBox(width: 10.w),
              Text(
                'Takes 4 Hour',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: 'Poppins3',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 17,
          ),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: buttonBlue3b5999,
                size: 8,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Every 6 Months or 5000 kms',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: 'Poppins3',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 17,
          ),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: buttonBlue3b5999,
                size: 8,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Alignment & Balancing Included',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: 'Poppins3',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 17,
          ),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: buttonBlue3b5999,
                size: 8,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'Wheel Rotation Inlcluded',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: 'Poppins3',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoButton1(String text) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 17.w, bottom: 5),
        child: Container(
          height: 30.h,
          width: 110.w,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 9.sp,
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
}
