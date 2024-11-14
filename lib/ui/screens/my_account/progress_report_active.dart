import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:imechano/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/bottombar/car_checkout.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/shared/widgets/show_alert_dialog.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../modal/send_notification_admin_modal.dart';
import '../../styling/config.dart';
import '../../styling/global.dart';
import '../../styling/image_enlarge.dart';

class ProgressReportActive extends StatefulWidget {
  const ProgressReportActive({this.job_number});
  final String? job_number;

  @override
  _ProgressReportActiveState createState() => _ProgressReportActiveState();
}

class _ProgressReportActiveState extends State<ProgressReportActive> {
  DateTime _selectedValue = DateTime.now();
  //DateTime _dateTime = DateTime.now();
  double hh = 0;
  double ww = 0;
  var steps = [];
  int check = 0;
  int deliveryStatus = 0;
  int reject_Status = 0;
  String carImage = "";
  int status = 0;
  XFile? image, temp;

  String id = "";
  List<String> ids = [];
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagefiles = <XFile>[];
  TextEditingController workdoneController = TextEditingController();
  final _repository = Repository();

  @override
  void initState() {
    log('Inside init state of progress report screen');
    super.initState();

    loadSteps();
  }

  dynamic appModelTheme;
  ValueNotifier<int> _index = ValueNotifier(0);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    log('Inside build of progress report screen');
    // print(steps.length);
    // print(ids);

    // print(status);
    hh = MediaQuery.of(context).size.height;
    ww = MediaQuery.of(context).size.width;
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => WillPopScope(
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
                key: _key,
                drawer: drawerpage(),
                backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
                appBar: WidgetAppBar(
                    title: getTranslated('progressreport', context),
                    menuItem: 'assets/svg/Menu.svg',
                    imageicon: 'assets/svg/Arrow_alt_left.svg',
                    action: 'assets/svg/shopping-cart.svg',
                    action2: 'assets/svg/ball.svg'),
                body: SingleChildScrollView(
                  child: Container(
                    height: hh * 0.9,
                    decoration: BoxDecoration(
                      color: appModelTheme.darkTheme ? darkmodeColor : white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),

                    // Car Pic Change Here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Image.network(
                            Config.imageurl + carImage,
                            height: 120.h,
                            errorBuilder: (context, object, stackTrace) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          // child: Image.asset("assets/images/Group 9247.png"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        steps.length > 0
                            ? Expanded(
                                child: ValueListenableBuilder(
                                    valueListenable: _index,
                                    builder: (context, value, child) {
                                      return Stepper(
                                        physics: ClampingScrollPhysics(),
                                        controlsBuilder: (BuildContext context,
                                            ControlsDetails controls) {
                                          return Row(
                                            children: <Widget>[
                                              Container(),
                                            ],
                                          );
                                        },
                                        currentStep: _index.value,
                                        onStepTapped: (int index) {
                                          _index.value = index;
                                        },
                                        steps: <Step>[
                                          for (int i = 0; i < steps.length; i++)
                                            Step(
                                              title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    steps[i]['item_id'] > 10000
                                                        ? Text(
                                                            steps[i]['name']
                                                                .toString()
                                                                .removeAllWhitespace,
                                                          )
                                                        : Text(getTranslated(
                                                            steps[i]['name']
                                                                .toString()
                                                                .removeAllWhitespace,
                                                            context)),
                                                    _index.value != i
                                                        ? Icon(
                                                            Icons.chevron_right,
                                                            size: 30,
                                                            color: Colors.blue,
                                                          )
                                                        : Container(),
                                                  ]),
                                              content: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child:
                                                    Column(children: <Widget>[
                                                  for (int j = 0;
                                                      j <
                                                          (steps[i]['work_image']
                                                                  .toString()
                                                                  .contains(",")
                                                              ? steps[i]['work_image']
                                                                      .split(
                                                                          ",")
                                                                      .length -
                                                                  1
                                                              : 0);
                                                      j++)
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  ImageDialog(
                                                                imageUrl: Config
                                                                        .imageurl +
                                                                    steps[i][
                                                                            'work_image']
                                                                        .split(
                                                                            ",")[j]
                                                                        .toString(), // Replace with your image URL
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child:
                                                                Image.network(
                                                              Config.imageurl +
                                                                  steps[i][
                                                                          'work_image']
                                                                      .split(
                                                                          ",")[j]
                                                                      .toString(),
                                                              height: 120,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  new Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 10),
                                                    child: Text(
                                                      steps[i]['status']
                                                                  .toString() ==
                                                              "0"
                                                          ? getTranslated(
                                                              'comingsoon',
                                                              context)
                                                          : steps[i]['status']
                                                                      .toString() ==
                                                                  "1"
                                                              ? getTranslated(
                                                                  'workdone',
                                                                  context)
                                                              : '',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  new Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          steps[i]['status'] !=
                                                                  "0"
                                                              ? steps[i]['work_done']
                                                                          .toString()
                                                                          .length >
                                                                      0
                                                                  ? steps[i][
                                                                      'work_done']
                                                                  : ""
                                                              : "",
                                                          maxLines: 10,
                                                          softWrap: true,
                                                          overflow:
                                                              TextOverflow.fade,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                              isActive:
                                                  steps[i]['status'] != "0"
                                                      ? true
                                                      : false,
                                            ),
                                        ],
                                      );
                                    }),
                              )
                            : Text(""),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                              height: 0.5,
                            ),
                          ),
                        ),
                        check == 0 || check == 1
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    check == 0
                                        ? getTranslated(
                                            'AdminHasNotRequestedYet', context)
                                        : getTranslated(
                                            'AdminHasRequestedForDelivery',
                                            context),
                                    style: TextStyle(
                                      fontFamily: 'Poppins1',
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _bookSchedule(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            : deliveryStatus == 1 || deliveryStatus == 2
                                ? status == 3
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            deliveryStatus == 1
                                                ? getTranslated(
                                                    "pleaseConfirmDeliveryorRejectwithreason",
                                                    context)
                                                : "",
                                            style: TextStyle(
                                              fontFamily: 'Poppins1',
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          //Confirm Delivertyyy
                                          _confirmDelivery(
                                              widget.job_number.toString()),
                                          reject_Status != 1
                                              ? _rejectDelivery()
                                              : Text("")
                                        ],
                                      )
                                    : Center(
                                        child: Text(
                                          getTranslated(
                                              'DeliveryRequestHasBeenAccepted',
                                              context),
                                          style: TextStyle(
                                            fontFamily: 'Poppins1',
                                            fontSize: 14,
                                          ),
                                        ),
                                      )
                                : Center(
                                    child: Text(
                                      getTranslated(
                                          'DeliveryRequestHasBeenAccepted',
                                          context),
                                      style: TextStyle(
                                        fontFamily: 'Poppins1',
                                        fontSize: 14,
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
            ));
  }

  Widget _bookSchedule() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 20),
      child: GestureDetector(
        onTap: () {
          check == 0
              ? showSnackBar(
                  context, getTranslated('AdminHasNotRequestedYet', context))
              : deliveryScheduleDialog(context);
        },
        child: Container(
          height: 48,
          width: 380.w,
          decoration: BoxDecoration(
            color: check == 0 ? Colors.grey : logoBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                getTranslated('acceptrequest', context),
                style: TextStyle(
                  fontFamily: 'Poppins1',
                  color: white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void confirmationDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: Text('Confirmation'),
  //       content: Text(
  //           'For the delivery schedule, you must pay 75% of the entire amount due. Would you like to continue?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             showSecondDialog(context);
  //           },
  //           child: Text('Yes'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context); // Close
  //           },
  //           child: Text('No'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void deliveryScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(20.h),
        child: Container(
          height: hh * 0.43,
          child: _DateTime(),
        ),
      ),
    );
  }

  Widget _confirmDelivery(String jobNumber) {
    if (deliveryStatus == 1) {
      return Padding(
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: GestureDetector(
          onTap: () async {
            // print("Job Number is ");
            // print(jobNumber);
            showDialog(
                context: context,
                builder: (_) => ShowAlertDialog(jobNo: jobNumber));

            // await acceptbookingApiCall(jobNumber);
            // currentJobcardTab = 1;
            // Get.offAll(() => BottomBarPage(3));
            // //onSendNotificationAdminAPI();
          },
          child: Container(
            height: 48,
            width: 380.w,
            decoration: BoxDecoration(
              color: deliveryStatus == 1 ? logoBlue : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  getTranslated('ConfirmDelivery', context),
                  style: TextStyle(
                    fontFamily: 'Poppins1',
                    color: white,
                    fontSize: 15,
                  ),
                ),
                // Icon(
                //   Icons.shopping_cart,
                //   color: white,
                // )
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: GestureDetector(
          onTap: () {
            showSnackBar(context,
                getTranslated('Youhavealreadyconfirmeddelivery', context));
          },
          child: Container(
            height: 48,
            width: 380.w,
            decoration: BoxDecoration(
              color: deliveryStatus == 1 ? logoBlue : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  getTranslated('DeliveryConfirmed', context),
                  style: TextStyle(
                    fontFamily: 'Poppins1',
                    color: white,
                    fontSize: 15,
                  ),
                ),
                // Icon(
                //   Icons.shopping_cart,
                //   color: white,
                // )
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _rejectDelivery() {
    if (deliveryStatus == 1) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 20, top: 20, bottom: 20),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => Container(
                margin: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 105.h, bottom: 135.h),
                child: StatefulBuilder(builder: (stfContext, stfSetState) {
                  return Material(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                getTranslated("unselected", context),
                                style: TextStyle(
                                    fontSize: 17, fontFamily: 'Poppins2'),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: steps.length,
                              itemBuilder: (context, index) {
                                return steps[index]['booking_id'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff70bdf1)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ), //BoxDecoration

                                          /** CheckboxListTile Widget **/
                                          child: CheckboxListTile(
                                            title:
                                                steps[index]['item_id'] > 10000
                                                    ? Text(
                                                        steps[index]['name']
                                                            .toString()
                                                            .removeAllWhitespace,
                                                      )
                                                    : Text(
                                                        getTranslated(
                                                            steps[index]['name']
                                                                .toString()
                                                                .removeAllWhitespace,
                                                            context),
                                                      ),
                                            secondary: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://pbs.twimg.com/profile_images/1304985167476523008/QNHrwL2q_400x400.jpg"), //NetworkImage
                                              radius: 20,
                                            ),
                                            autofocus: false,
                                            activeColor: Color(0xff70bdf1),
                                            checkColor: Colors.white,
                                            selected: steps[index]['status']
                                                        .toString() ==
                                                    "1"
                                                ? true
                                                : false,
                                            dense: true,
                                            value: steps[index]['status']
                                                        .toString() ==
                                                    "1"
                                                ? true
                                                : false,
                                            onChanged: (bool? value) {
                                              // set up the buttons
                                              Widget cancelButton = TextButton(
                                                child: Text(getTranslated(
                                                    'cancel', context)),
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                              );
                                              Widget continueButton =
                                                  TextButton(
                                                      child: Text(getTranslated(
                                                          "OK", context)),
                                                      onPressed: () {
                                                        stfSetState(() {
                                                          id = steps[index]
                                                                  ['id']
                                                              .toString();
                                                          if (ids
                                                              .contains(id)) {
                                                            ids.remove(id);
                                                            steps[index]
                                                                    ['status'] =
                                                                "1";
                                                          } else {
                                                            ids.add(id);
                                                            steps[index]
                                                                    ['status'] =
                                                                "0";
                                                          }

                                                          print(ids);
                                                        });

                                                        Navigator.pop(
                                                            context, 'Ok');
                                                      });
                                              if (steps[index]['status']
                                                      .toString() ==
                                                  "1") {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: Text(getTranslated(
                                                        'confirmition',
                                                        context)),
                                                    content: Text(getTranslated(
                                                        'delivery_rejected_message',
                                                        context)),
                                                    actions: <Widget>[
                                                      cancelButton,
                                                      continueButton,
                                                    ],
                                                  ),
                                                ).then((value) => print(value));
                                              } else {
                                                // showDialog<String>(
                                                //   context: context,
                                                //   builder:
                                                //       (BuildContext context) =>
                                                //           AlertDialog(
                                                //     title: const Text(
                                                //         'Confirmation'),
                                                //     content: const Text(
                                                //         'Are you sure to Mark this Work as  Completed? Admin will be notified!'),
                                                //     actions: <Widget>[
                                                //       cancelButton,
                                                //       continueButton,
                                                //     ],
                                                //   ),
                                                // ).then((value) => print(value));
                                                Fluttertoast.showToast(
                                                    msg: getTranslated(
                                                        "youcannot", context),
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.black,
                                                    fontSize: 16.0);
                                              }
                                            },
                                          ), //CheckboxListTile
                                        ),
                                      )
                                    : Text(
                                        '',
                                        style: TextStyle(
                                            fontFamily: 'Poppins1',
                                            fontSize: 18.sp),
                                      );
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                Loader().showLoader(context);
                                rejectStatus(ids);
                                Future.delayed(Duration(milliseconds: 500));
                                Loader().hideLoader(context);
                                Fluttertoast.showToast(
                                    msg: getTranslated(
                                        "DeliveryRejected!", context),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                currentJobcardTab = 3;

                                Get.offAll(() => BottomBarPage(3));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: logoBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, top: 10, bottom: 10),
                                child: Text(
                                  getTranslated("submit", context),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'Poppins3'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
          child: Container(
            height: 48,
            width: 380.w,
            decoration: BoxDecoration(
              color: deliveryStatus == 1 ? Colors.red : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  getTranslated("reject_delivey", context),
                  style: TextStyle(
                    fontFamily: 'Poppins1',
                    color: white,
                    fontSize: 15,
                  ),
                ),
                // Icon(
                //   Icons.shopping_cart,
                //   color: white,
                // )
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: GestureDetector(
          onTap: () {
            showSnackBar(context,
                getTranslated('Youhavealreadyconfirmeddelivery', context));
          },
          child: Container(
            height: 48,
            width: 380.w,
            decoration: BoxDecoration(
              color: deliveryStatus == 1 ? logoBlue : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  getTranslated('DeliveryConfirmed', context),
                  style: TextStyle(
                    fontFamily: 'Poppins1',
                    color: white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _DateTime() {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10,
        color: appModelTheme.darkTheme ? darkmodeColor : Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: appModelTheme.darkTheme
                      ? Color(0xff252525)
                      : Color(0xff70bdf1)),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(getTranslated('SelectDateandTime', context),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins1')),
                  ),
                  SizedBox(height: 5.h),
                  Divider(color: Colors.white),
                  // Center(
                  //   child: DatePicker(
                  //     DateTime.now(),
                  //     height: hh * 0.13,
                  //     initialSelectedDate: DateTime.now(),
                  //     selectionColor: appModelTheme.darkTheme
                  //         ? darkmodeColor
                  //         : Colors.transparent,
                  //     selectedTextColor: Colors.white,
                  //     onDateChange: (date) {
                  //       // New date selected
                  //       setState(() {
                  //         _selectedValue = date;
                  //       });
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            _dateAndTime(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all()),
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 10, bottom: 10),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins3',
                          color:
                              appModelTheme.darkTheme ? white : Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                GestureDetector(
                  //Work Here
                  onTap: () async {
                    DateTime currentTime = DateTime.now();
                    DateTime twoHoursLater =
                        currentTime.add(Duration(hours: 2));
                    log('${_selectedValue.hour} ${_selectedValue.minute}');
                    if (_selectedValue.hour < 8 ||
                        (_selectedValue.hour >= 23 &&
                            _selectedValue.minute >= 60)) {
                      Fluttertoast.showToast(
                          msg: 'Please choose a time between 8am-11:59pm',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (_selectedValue.isBefore(twoHoursLater)) {
                      Utils.showToast(
                          'Please select a booking time atleast 2hrs later');
                    } else if (reject_Status != 1) {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => CheckOut(
                      //             jobNo: widget.job_number!,
                      //             dateTime: _selectedValue,
                      //             choice: 3)));
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'You have to pay 75% of the entire amount due for delivery schedule, Would you like to continue?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, // function used to perform after pressing the button
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckOut(
                                          jobNo: widget.job_number!,
                                          dateTime: _selectedValue,
                                          choice: 3)),
                                );
                                // Loader().showLoader(context);
                                // await _repository.scheduledelivery(
                                //   widget.job_number!,
                                //   DateFormat('yyyy/MM/dd kk:mm')
                                //       .format(_dateTime),
                                // );
                                // Loader().hideLoader(context);
                                // Navigator.pop(context);
                                // Navigator.pop(context);
                                // Navigator.pop(context);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      Loader().showLoader(context);
                      await _repository.scheduledelivery(
                        widget.job_number!,
                        DateFormat('yyyy/MM/dd kk:mm').format(_selectedValue),
                      );
                      Loader().hideLoader(context);
                      currentJobcardTab = 3;

                      Get.offAll(() => BottomBarPage(3));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: logoBlue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 10, bottom: 10),
                    child: Text(
                      getTranslated('Submit', context),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Poppins3'),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
            SizedBox(height: 50.h)
          ],
        ),
      ),
    );
  }

  Widget _dateAndTime() {
    return Container(
      height: hh * 0.25,
      child: CupertinoDatePicker(
        minimumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.dateAndTime,
        onDateTimeChanged: (datetime) {
          print(datetime);
          setState(() {
            _selectedValue = datetime;
          });
        },
        initialDateTime: DateTime.now(),
        use24hFormat: false,
      ),
    );
  }

  loadSteps() async {
    log(widget.job_number.toString());
    var request = http.MultipartRequest(
        'POST', Uri.parse(Config.apiurl + Config.viewitems));
    request.fields.addAll({
      'job_number': widget.job_number.toString(),
    });
    print("Iam here");
    var res = request
        .send()
        .then((value) => http.Response.fromStream(value).then((onvalue) {
              final result = jsonDecode(onvalue.body) as Map<String, dynamic>;

              print(result['message']);

              if (result['code'] != '0') {
                setState(() {
                  // add image api
                  print("IFFS");
                  carImage = result['carImage'];
                  steps = result['data'];
                  print(steps);

                  var booking = result['booking'];

                  deliveryStatus =
                      int.parse(booking['delivery_status'].toString());
                  reject_Status = booking['reject_status'];
                  print(result['request']);
                  check = result['request'];
                  print("Printing Status");
                  status = result['status'];
                  print(result['data'].toString());

                  print(steps[0]['name']);
                });
              } else {
                print(result['message'].toString());
              }
            }));
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

  dynamic onSendNotificationAdminAPI() async {
    // show loader
    Loader().showLoader(context);
    final SendNotificationAdminModel isAdmin =
        await _repository.onSendNotificationAdminAPI(
            'Delivery Confirmed', 'User has confirmed delivery.');
    Loader().hideLoader(context);
    if (isAdmin.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);
      return showSnackBar(context, "You have confirmed delivery. Thank you");
    } else {
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isAdmin.message != null ? isAdmin.message! : '');
    }
  }

  dynamic onRejectSendNotificationAdminAPI() async {
    // show loader
    Loader().showLoader(context);
    final SendNotificationAdminModel isAdmin =
        await _repository.onSendNotificationAdminAPI('Delivery Rejected',
            'User has rejected delivery. Please check rejected Job Card!');
    Loader().hideLoader(context);
    if (isAdmin.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);
      return showSnackBar(
          context, "You have rejected delivery. We will contact you soon!");
    } else {
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isAdmin.message != null ? isAdmin.message! : '');
    }
  }

  // Widget _ItemsList() {
  //   return
  // }

  Widget _dialogBox_CheckBox() {
    imagefiles = null;
    workdoneController.text = "";
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w, top: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                            'assets/icons/My Account/Group 9412.png',
                            cacheHeight: 20,
                            cacheWidth: 20),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 17.sp, fontFamily: 'Poppins2'),
                  ),
                ),
                Center(
                  child: Text(
                    'File Should be PNG of JPEG',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: 'Poppins1',
                      color: buttonNaviBlue4c5e6bBorder,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
            SizedBox(height: 10.h),
            _dottedContainer(),
            SizedBox(height: 10.h),
            _containerTextfield(),
            SizedBox(height: 40.h),
            _submitButton(),
            SizedBox(height: 40.h),
            _submitWithoutImagesButton(),
            SizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }

  Widget _dottedContainer() {
    return DottedBorder(
        color: Color(0xff70BDF1),
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        dashPattern: [5, 5],
        child: StatefulBuilder(
          builder: (context, setState1) => ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width * 0.77,
                  color: Color(0xffF5FAFF),
                  child: Column(
                    children: [
                      // SizedBox(height: 20),
                      // Image.asset('assets/icons/My Account/file.png',
                      //     cacheHeight: 50, cacheWidth: 55),
                      // SizedBox(height: 10),
                      // GestureDetector(
                      //
                      //   child: Text(
                      //     'Upload here Your car\'s images',
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       fontFamily: 'Poppins1',
                      //       color: buttonNaviBlue4c5e6bBorder,
                      //     ),
                      //   ),
                      // ),
                      imagefiles != null
                          ? Wrap(
                              children:
                                  imagefiles!.asMap().entries.map((entry) {
                                int index = entry.key;
                                XFile imageone = entry.value;
                                return Container(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Stack(
                                    children: [
                                      Card(
                                        child: Container(
                                          height: 100,
                                          width:
                                              100 / (imagefiles!.length * 0.5),
                                          child:
                                              Image.file(File(imageone.path)),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (imagefiles!.isNotEmpty) {
                                              imagefiles!.removeAt(index);
                                              setState(() {});
                                            }
                                          },
                                          child: SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: Icon(
                                                Icons.clear,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                          : Container(
                              child: Column(children: [
                              SizedBox(height: 20),
                              Image.asset('assets/icons/My Account/file.png',
                                  cacheHeight: 50, cacheWidth: 55),
                              SizedBox(height: 10),
                              GestureDetector(
                                child: Text(
                                  'Upload here Your car\'s images',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins1',
                                    color: buttonNaviBlue4c5e6bBorder,
                                  ),
                                ),
                              ),
                            ]))
                    ],
                  ),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Center(
                          child: Text(
                            "SELECT ANY ONE",
                            style: TextStyle(fontFamily: "Poppins2"),
                          ),
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SimpleDialogOption(
                                child: InkWell(
                                  onTap: () async {
                                    openCamera();
                                    // image = await _picker.pickImage(
                                    //     source: ImageSource.camera);
                                    // if (image != null) {
                                    //   setState(() {
                                    //     temp = image;
                                    //     XFile imageFile = XFile(image!.path);
                                    //
                                    //     var imagefile = imageFile as List<XFile>?;
                                    //     imagefiles = [...?imagefiles, ...?imagefile].toSet().toList();
                                    //   });
                                    //
                                    // }
                                    // Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: logoBlue,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Camera",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontFamily: "Poppins1"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SimpleDialogOption(
                                child: InkWell(
                                  onTap: () async {
                                    openGallery();
                                    // image = await _picker.pickImage(
                                    //     source: ImageSource.gallery);
                                    //
                                    // setState(() {
                                    //   temp = image;
                                    // });
                                  },
                                  child: Container(
                                    height: 60.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: logoBlue,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Gallery",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontFamily: "Poppins1"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }),
          ),
        ));
  }

  void rejectStatus(List<String> _id) async {
    Loader().showLoader(context);

    try {
      final uri = Uri.parse(Config.apiurl + "reject-delivery");
      dynamic postData = {
        'id': _id,
      };
      log('REJECTING DELIVERY');
      log(postData.toString());
      log(postData.runtimeType.toString());
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }

    Loader().hideLoader(context);
  }

  Widget _containerTextfield() {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height / 9.8,
        margin: EdgeInsets.only(left: 40, right: 40),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: TextField(
            controller: workdoneController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: buttonNaviBlue4c5e6bBorder,
                  fontFamily: 'Poppins1',
                  fontSize: 14,
                ),
                hintText: 'Rejection Reason...'),
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        print("test");
        print(temp);
        if (workdoneController.text.isEmpty) {
          Fluttertoast.showToast(
              msg: 'Please Add Details',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0);
        } else if (imagefiles == null) {
          // snackBar('Please Add Image');
          Fluttertoast.showToast(
              msg: 'Please Add Image',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0);
        } else {
          // uploadImageHTTP(imagefiles!);
          // Navigator.pop(context);
          onRejectSendNotificationAdminAPI();
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 40.w, right: 40.w),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: logoBlue,
        ),
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(
              color: white,
              fontFamily: 'Poppins1',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitWithoutImagesButton() {
    return GestureDetector(
      onTap: () {
        // updateCustomerItemApi(id.toString());
        // Navigator.pop(context);
        onRejectSendNotificationAdminAPI();
      },
      child: Container(
        margin: EdgeInsets.only(left: 40.w, right: 40.w),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: logoBlue,
        ),
        child: Center(
          child: Text(
            'Submit without Images',
            style: TextStyle(
              color: white,
              fontFamily: 'Poppins1',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  openCamera() async {
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        temp = image;
        List<XFile>? imagefile = <XFile>[];
        imagefile.add(image);

        setState(() {
          imagefiles = [...?imagefiles, ...imagefile].toSet().toList();
        });
        Navigator.pop(context);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file. $e");
    }
  }

  openGallery() async {
    try {
      var pickedfiles = await _picker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        setState(() {
          imagefiles = [...?imagefiles, ...pickedfiles].toSet().toList();
        });
        Navigator.pop(context);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }
}
