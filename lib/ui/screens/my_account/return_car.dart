// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/screens/my_account/return_car_checkout.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/styling/colors.dart';

class ReturnCar extends StatefulWidget {
  const ReturnCar({Key? key}) : super(key: key);

  @override
  _ReturnCarState createState() => _ReturnCarState();
}

class _ReturnCarState extends State<ReturnCar> {
  DateTime _selectedValue = DateTime.now();
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
            appBar: WidgetAppBar(
                title: 'Return Car',
                menuItem: 'assets/svg/Arrow_alt_left.svg',
                action2: 'assets/svg/ball.svg'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      new Container(
                        height: 150.0.h,
                        width: double.infinity,
                        decoration: new BoxDecoration(
                          color: logoBlue,
                          borderRadius: new BorderRadius.vertical(
                              bottom: new Radius.elliptical(
                                  MediaQuery.of(context).size.width, 200.0)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 30, right: 20),
                        height: 390.h,
                        width: 354.w,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(children: [
                              SizedBox(height: 15.h),
                              Center(
                                child: Text(
                                  'Oder ID: 125462',
                                  style: TextStyle(
                                      fontFamily: "Poppins2", fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "You Car is Ready to Drive",
                                style: TextStyle(
                                    fontFamily: "Poppins2", fontSize: 15),
                              ),
                              Container(
                                margin: EdgeInsets.all(7.h),
                                child: Text(
                                  "Securely Ready and return your car to \niMechano by Nov 25,2021 We've message \nthese details to you +91-1234569722",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "Poppins1"),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Image.asset(
                                      "assets/images/Group 9248.png",
                                      height: 100,
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Oil Filter Change Service",
                                          style: TextStyle(
                                              fontFamily: "poppins1",
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "Brake Service",
                                          style: TextStyle(
                                              fontFamily: "poppins1",
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "Engine Service",
                                          style: TextStyle(
                                              fontFamily: "poppins1",
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Image.asset(
                                "assets/icons/select_car/2021-BMW.png",
                                height: 125.h,
                              ),
                            ])),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          "Vehicle Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins2",
                              fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text(
                          'Model',
                          style: TextStyle(fontFamily: "Poppins2"),
                        )),
                        DataColumn(
                            label: Text(
                          'Hyundai Grand I10',
                          style: TextStyle(fontFamily: "Poppins2"),
                        )),
                      ],
                      showBottomBorder: true,
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(
                            'Cylinder Type',
                            style: TextStyle(fontFamily: "Poppins1"),
                          )),
                          DataCell(Text('V4')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Mileage',
                            style: TextStyle(fontFamily: "Poppins1"),
                          )),
                          DataCell(Text('20-28 km/I combined')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Model Year',
                            style: TextStyle(fontFamily: "Poppins1"),
                          )),
                          DataCell(Text('2020')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Plate Number',
                            style: TextStyle(fontFamily: "Poppins1"),
                          )),
                          DataCell(Text('HR-01-AM5652')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Vin Chases ',
                            style: TextStyle(fontFamily: "Poppins1"),
                          )),
                          DataCell(Text('MALAM51BLJM614018A')),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => Container(
                                margin: EdgeInsets.only(
                                    left: 20.w,
                                    right: 20.w,
                                    top: 100.h,
                                    bottom: 150.h),
                                child: _DateTime()));

                        // Get.offNamed('/PrivacyPolicyScreene');
                      },
                      child: SizedBox(
                          width: 310.w,
                          height: 50.h,
                          child: Center(
                              child: Text(
                            "Return Car",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.h,
                                fontFamily: "Poppins1"),
                          )))),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            )));
  }

  Widget _DateTime() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 10,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 132.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Color(0xff70bdf1)),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(getTranslated('selectdateandtime', context),
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.transparent,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedValue = date;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Time(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 35.h,
                width: 110.w,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              SizedBox(
                height: 35.h,
                width: 110.w,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(ReturnCarCheckOut());
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget Time() {
    return Container(
      height: 250,
      child: CupertinoDatePicker(
        minimumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (datetime) {
          print(datetime);
          setState(() {
            _dateTime = datetime;
          });
        },
        initialDateTime: DateTime.now(),
        use24hFormat: false,
      ),
    );
  }
}
