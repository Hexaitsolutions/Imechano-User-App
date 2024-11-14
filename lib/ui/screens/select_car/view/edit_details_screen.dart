// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano/ui/bloc/select-car-details_bloc.dart';
import 'package:imechano/ui/modal/select-car-details_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/my%20invoice.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/buttons/custom_button.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

class EditDetailsScreen extends StatefulWidget {
  final String? id;
  const EditDetailsScreen({Key? key, this.id}) : super(key: key);

  @override
  _EditDetailsScreenState createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    carDetailsBloc.carDetailssink(widget.id.toString());
  }

  dynamic appModelTheme;
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      appBar: WidgetAppBar(
        title: 'My Vehicle',
        menuItem: 'assets/svg/Arrow_alt_left.svg',
      ),
      body: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => StreamBuilder<CarDetailsModel>(
            stream: carDetailsBloc.carDetailsstream,
            builder:
                (context, AsyncSnapshot<CarDetailsModel> carDetailsnapshort) {
              if (!carDetailsnapshort.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          new Container(
                            height: 150.0.h,
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              color: appModelTheme.darkTheme ? black : logoBlue,
                              borderRadius: new BorderRadius.vertical(
                                  bottom: new Radius.elliptical(
                                      MediaQuery.of(context).size.width,
                                      200.0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Card(),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Center(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 28.w, right: 28.w),
                                  child: Card(
                                    color: appModelTheme.darkTheme
                                        ? darkmodeColor
                                        : white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15.h),
                                        Center(
                                          child: Text(
                                            carDetailsnapshort.data!.data!.model
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: "Poppins1",
                                                fontSize: 15.sp),
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        Image.asset(
                                          "assets/icons/select_car/2021-BMW.png",
                                          height: 121.h,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: Divider(
                                            color: Color(0xffEFEFEF),
                                            thickness: 0.5,
                                            height: 0.5.h,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 13.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              ' Fuel Type',
                                              style: TextStyle(
                                                  fontFamily: "Poppins1",
                                                  fontSize: 15.sp),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ButtonTheme(
                                                height: 35.h,
                                                minWidth: 112.w,
                                                child: MaterialButton(
                                                  color: logoBlue,
                                                  child: carDetailsnapshort
                                                              .data!
                                                              .data!
                                                              .fuelType! !=
                                                          null
                                                      ? Text(
                                                          carDetailsnapshort
                                                              .data!
                                                              .data!
                                                              .fuelType!,
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Poppins1"),
                                                        )
                                                      : Text('-'),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      "Vehicle Details",
                                      style: TextStyle(
                                          color: appModelTheme.darkTheme
                                              ? white
                                              : black,
                                          fontFamily: "Poppins1",
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              SingleChildScrollView(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 28.w, right: 28.w),
                                  width: double.infinity,
                                  child: DataTable(
                                    border: TableBorder.all(
                                        width: 1.0, color: grayE6E6E5),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'Model',
                                        style: TextStyle(
                                            fontFamily: "Poppins3",
                                            fontSize: 13.sp),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        carDetailsnapshort.data!.data!.model!,
                                        style: TextStyle(
                                            fontFamily: "Poppins3",
                                            fontSize: 13.sp),
                                      )),
                                    ],
                                    rows: [
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              'Cylinder Type',
                                              style: TextStyle(
                                                  fontFamily: "Poppins3",
                                                  fontSize: 13.sp),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                                carDetailsnapshort
                                                    .data!.data!.cylinder!,
                                                style: TextStyle(
                                                    fontFamily: "Poppins3",
                                                    fontSize: 13.sp)),
                                          ),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              'Mileage',
                                              style: TextStyle(
                                                  fontFamily: "Poppins3",
                                                  fontSize: 13.sp),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                                carDetailsnapshort
                                                    .data!.data!.mileage!,
                                                style: TextStyle(
                                                    fontFamily: "Poppins3",
                                                    fontSize: 13.sp)),
                                          ),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              'Model Year',
                                              style: TextStyle(
                                                  fontFamily: "Poppins3",
                                                  fontSize: 13.sp),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                                carDetailsnapshort
                                                    .data!.data!.modelYear!,
                                                style: TextStyle(
                                                    fontFamily: "Poppins3",
                                                    fontSize: 13.sp)),
                                          ),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              'Plate Number',
                                              style: TextStyle(
                                                  fontFamily: "Poppins3",
                                                  fontSize: 13.sp),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                                carDetailsnapshort
                                                    .data!.data!.plateNumber!,
                                                style: TextStyle(
                                                    fontFamily: "Poppins3",
                                                    fontSize: 13.sp)),
                                          ),
                                        ],
                                      ),
                                      DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              'Vin Chases ',
                                              style: TextStyle(
                                                  fontFamily: "Poppins3",
                                                  fontSize: 13.sp),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                                carDetailsnapshort
                                                    .data!.data!.chasesNumber!,
                                                style: TextStyle(
                                                    fontFamily: "Poppins3",
                                                    fontSize: 13.sp)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                title: Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 18.sp, fontFamily: "Poppins1"),
                                ),
                                width: 0.8.w,
                                bgColor: logoBlue,
                                borderColor: logoBlue,
                                callBackFunction: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyInvoice(),
                                      ));
                                },
                              ),
                              SizedBox(
                                height: 30.h,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
