import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/modal/Approvedcharged_model.dart';
import 'package:imechano/ui/modal/approve_jobcard_model.dart';
import 'package:imechano/ui/modal/send_notification_admin_modal.dart';
import 'package:imechano/ui/provider/generate_invoice_provider.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';

import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../localization/language_constrants.dart';

class CheckOut extends StatefulWidget {
  final String bookingId;
  final String jobNo;
  final DateTime? dateTime;
  final String deliveryCharges;
  final String total;
  final int choice;

  CheckOut({
    this.bookingId = '',
    this.jobNo = '',
    this.dateTime,
    this.choice = 0,
    this.deliveryCharges = '0',
    this.total = '0',
  });
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _repository = Repository();

  bool value = false;
  int val = -1;
  List _nameList = [];

  @override
  void dispose() {
    // TODO: implement dispose
    log('Checkout screen disposed');
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (selectedService['item_name'] != null) {
      _nameList = selectedService['item_name'];
    }
    getAddress();
  }

  double hh = 0;
  double ww = 0;
  SharedPreferences? prefs;

  marker() async {
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(double.parse(lat), double.parse(long)),
        infoWindow: InfoWindow(title: 'The title of the marker')));
  }

  getAddress() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      address = prefs!.getString('address') ?? 'Select your address';
      long = prefs!.getString('lontitude') ?? '0.00';
      lat = prefs!.getString('latitude') ?? '0.00';
      loadMap = true;
    });

    await marker();
  }

  bool loadMap = true;
  var address;
  dynamic lat = 0.obs;
  dynamic long;
  List<Marker> _markers = <Marker>[];

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  dynamic appModelTheme;
  @override
  Widget build(BuildContext context) {
    // print(selectedService!['item_name']);
    if (selectedService['item_name'] != null) {
      _nameList = selectedService['item_name'];
    }
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
        key: _key,
        drawer: drawerpage(),
        appBar: WidgetAppBar(
          title: getTranslated('checkout', context),
          imageicon: 'assets/svg/Arrow_alt_left.svg',
          menuItem: 'assets/svg/Menu.svg',
          home: 'assets/svg/homeicon.svg',
          //action: 'assets/svg/shopping-cart.svg',
        ),
        backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: appModelTheme.darkTheme ? Color(0xff252525) : white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0))),
                child: _body(),
              ),
            ),
          ]),
        ));
  }

  Widget _body() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.023),
          _delAddressTag(),
          SizedBox(height: size.height * 0.023),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                margin: EdgeInsets.only(
                    left: ww * 0.08,
                    right: ww * 0.08,
                    top: hh * 0.01,
                    bottom: hh * 0.01),
                height: MediaQuery.of(context).size.height * 0.15,
                child: loadMap == true
                    ? GoogleMap(
                        onTap: (argument) {
                          print(double.parse(lat));
                          print(double.parse(long));
                        },
                        scrollGesturesEnabled: false,
                        markers: Set<Marker>.of(_markers),
                        myLocationButtonEnabled: true,
                        myLocationEnabled: false,
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          //target: LatLng(double.parse(lat), double.parse(long)),
                          target: LatLng(double.parse(lat), double.parse(long)),
                          zoom: 15,
                        ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
          ),
          SizedBox(height: size.height * 0.023),
          _changeAddress(),
          SizedBox(height: size.height * 0.023),
          _addLocationComment(),
          SizedBox(height: size.height * 0.023),
          _customDivider(),
          SizedBox(height: size.height * 0.023),
          _paymentMethod(),
          SizedBox(height: size.height * 0.023),
          methidOFtransaction(),
          SizedBox(height: size.height * 0.023),
          _customDivider(),
          SizedBox(height: size.height * 0.023),
          _delChange(),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(),
          ),
          SizedBox(height: size.height * 0.02),
          _delTotal(),
          SizedBox(height: size.height * 0.05),
          _placeBookingbutton()
        ],
      ),
    );
  }

  Widget _delAddressTag() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
      child: Text(getTranslated('deliveryaddress', context),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins3',
          )),
    );
  }

  Widget _addLocationComment() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          // padding: EdgeInsets.all(5),
          // width: 30,
          padding: EdgeInsets.only(left: 15),
          margin: EdgeInsets.only(left: ww * 0.07, right: ww * 0.05),
          decoration: BoxDecoration(
            color: appModelTheme.darkTheme ? darkmodeColor : Color(0xffE6E6E5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 20,
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: getTranslated('additionallocationcomment', context),
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins3',
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ))
            ],
          )),
    );
  }
  // Widget _addressMap() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 20, right: 20, top: 10),
  //     child: Container(
  //       height: 79.h,
  //       width: 367.w,
  //       child: Image.asset(
  //         'assets/images/google_picture.png',
  //         fit: BoxFit.fitWidth,
  //       ),
  //     ),
  //   );
  // }

  Widget _changeAddress() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 5),
          Expanded(
            child: Text(
              '$address',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins1',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 20),
            child: GestureDetector(
              onTap: () {
                // setState(() {});

                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) {
                //     return MapLocation(
                //       callBackFunction: (mainAddress) {
                //         _markers = <Marker>[];
                //         getAddress();

                //         setState(() {});
                //       },
                //     );
                //   },
                // ));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    size: 15,
                    color: red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    getTranslated('change', context),
                    style: TextStyle(
                      fontSize: 13,
                      color: red,
                      fontFamily: 'Poppins1',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  // Widget _cardList() {
  //   return ListView.builder(
  //     physics: NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: _nameList.length,
  //     itemBuilder: (context, index) {
  //       return Padding(
  //         padding:
  //             const EdgeInsets.only(left: 26, right: 20, bottom: 15, top: 15),
  //         child: Container(
  //           decoration: BoxDecoration(
  //               color: appModelTheme.darkTheme ? darkmodeColor : white,
  //               borderRadius: BorderRadius.circular(20),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: appModelTheme.darkTheme
  //                       ? black
  //                       : Colors.grey.withOpacity(0.2),
  //                   spreadRadius: 2,
  //                   blurRadius: 10,
  //                   offset: Offset(0, 3), // changes position of shadow
  //                 ),
  //               ]),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(height: 10),
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                   left: 23,
  //                 ),
  //                 child: Text(
  //                   '${_nameList[index]}',
  //                   style: TextStyle(
  //                     fontSize: 13,
  //                     fontFamily: 'Poppins1',
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(left: 20),
  //                 child: Row(
  //                   children: [
  //                     Icon(
  //                       Icons.star,
  //                       size: 10,
  //                       color: presenting,
  //                     ),
  //                     SizedBox(width: 2.w),
  //                     Text(
  //                       '4.5',
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         fontFamily: 'Poppins1',
  //                         color: presenting,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: 5,
  //                     ),
  //                     Text(
  //                       '250 Ratings',
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         fontFamily: 'Poppins3',
  //                         color: Colors.black38,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 20, top: 15),
  //                 child: Row(
  //                   children: [
  //                     Icon(
  //                       Icons.circle,
  //                       color: Colors.blue,
  //                       size: 7,
  //                     ),
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                     Text(
  //                       'Takes 4 Hour',
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         fontFamily: 'Poppins3',
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                   left: 20,
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     Icon(
  //                       Icons.circle,
  //                       color: Colors.blue,
  //                       size: 7,
  //                     ),
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                     Text(
  //                       'Every 6 Months or 5000 kms',
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         fontFamily: 'Poppins3',
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                   left: 20,
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     Icon(
  //                       Icons.circle,
  //                       color: Colors.blue,
  //                       size: 7,
  //                     ),
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                     Text(
  //                       // ========================by jenish==========================
  //                       'Alignment & Balancing Included',
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         fontFamily: 'Poppins3',
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // ========================by jenish==========================
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                   left: 20,
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     Icon(
  //                       Icons.circle,
  //                       color: Colors.blue,
  //                       size: 7,
  //                     ),
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                     Text(
  //                       // ========================by jenish==========================
  //                       'Wheel Rotation Inlcluded',
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         fontFamily: 'Poppins3',
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _changeOilTag() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 27),
  //     child: Text(catogoryName,
  //         style: TextStyle(
  //           fontSize: 15,
  //           fontFamily: 'Poppins1',
  //         )),
  //   );
  // }

  Widget _customDivider() {
    return Divider(
      thickness: 10,
      color: appModelTheme.darkTheme ? darkmodeColor : apptransbackcolor,
    );
  }

  Widget _paymentMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              getTranslated('paymentmethod', context),
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins1',
                  fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
              onTap: () {},
              child: Container(
                child: Text(
                  '+ ${getTranslated('addcard', context)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffED4E46),
                    fontFamily: 'Metropolis1',
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget methidOFtransaction() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          // Container(
          //   height: size.height * 0.06,
          //   decoration: BoxDecoration(
          //     color:
          //         appModelTheme.darkTheme ? darkmodeColor : apptransbackcolor,
          //     border: Border.all(
          //       color:
          //           appModelTheme.darkTheme ? darkmodeColor : apptransbackcolor,
          //     ),
          //     borderRadius: BorderRadius.circular(6.0),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //     Padding(
          //       padding: EdgeInsets.only(left: 20, right: 20),
          //       child: Container(
          //         child: Text(
          //           'Pay On Delivery(POS Machine)',
          //           style: TextStyle(
          //             fontSize: 12,
          //             fontFamily: 'Poppins3',
          //           ),
          //         ),
          //       ),
          //     ),
          //     Container(
          //       // height: 20.h,
          //       width: size.width * 0.06,
          //       child: Radio(
          //         fillColor: MaterialStateColor.resolveWith(
          //             (states) => Color(0xffED4E46)),
          //         value: 1,
          //         groupValue: val,
          //         activeColor: Color(0xffED4E46),
          //         onChanged: (value) {
          //           setState(() {
          //             val = value as int;
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          //),
          //SizedBox(height: size.height * 0.018),
          Container(
            height: size.height * 0.06,
            decoration: BoxDecoration(
              color:
                  appModelTheme.darkTheme ? darkmodeColor : apptransbackcolor,
              border: Border.all(
                color:
                    appModelTheme.darkTheme ? darkmodeColor : apptransbackcolor,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    child: Row(
                      children: [
                        Image.asset("assets/images/visa.png", scale: 5),
                        Text(
                          '**** **** **** 2187',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins1',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // height: size.height * 0.01,
                  width: size.width * 0.06,
                  child: Radio(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xffED4E46)),
                    value: 2,
                    groupValue: val,
                    activeColor: Color(0xffED4E46),
                    onChanged: (value) {
                      setState(() {
                        val = value as int;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _delChange() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated('subtotal', context),
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins3',
                ),
              ),
              Text(
                '${getTranslated('qr', context)}' + ': 4,000.00',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins2',
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated('deliverycharges', context),
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins3',
                ),
              ),
              Text(
                '${getTranslated('qr', context)}' + ': 45.00',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 13, fontFamily: 'Poppins2', color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _delTotal() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated('total', context),
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins2',
            ),
          ),
          Text(
            '${getTranslated('qr', context)}' + ': 4,045.00',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins2',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  //PLACE BOOKING WIDGET
  Widget _placeBookingbutton() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () async {
          if (widget.choice == 1) {
            await payConfirmApiCall(widget.bookingId);
            Get.offAll(() => BottomBarPage(1));
          } else if (widget.choice == 2) {
            {
              bool response = await acceptbookingApiCall(widget.jobNo);
              if (response) {
                Loader().showLoader(context);
                bool response = await GenerateInvoiceProvider.generateInvoice(
                    widget.jobNo, widget.deliveryCharges, widget.total, 1);
                Loader().hideLoader(context);
                if (response) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Invoice generated successfully'),
                    duration: Duration(seconds: 3),
                  ));
                  Get.offAll(() => BottomBarPage(3));
                  currentJobcardTab = 3;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Something went wrong, try again!'),
                    duration: Duration(seconds: 3),
                  ));
                }
              }
            }
          } else if (widget.choice == 3) {
            Loader().showLoader(context);
            await _repository.scheduledelivery(
              widget.jobNo,
              DateFormat('yyyy/MM/dd kk:mm').format(widget.dateTime!),
            );
            bool response = await GenerateInvoiceProvider.generateInvoice(
                widget.jobNo, widget.deliveryCharges, widget.total, 2);

            Loader().hideLoader(context);

            if (response) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Invoice generated successfully'),
                duration: Duration(seconds: 3),
              ));

              Get.offAll(() => BottomBarPage(3));
              currentJobcardTab = 3;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text('Something went wrong, try again!'),
                duration: Duration(seconds: 3),
              ));
            }
          } else if (widget.choice == 4) {
            bool response = await acceptbookingApiCall(widget.jobNo);
            if (response) {
              Get.offAll(() => BottomBarPage(3));
              currentJobcardTab = 1;
            }
          }
        },
        child: Container(
          height: size.height * 0.08,
          width: double.infinity,
          decoration: BoxDecoration(
            color: logoBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              getTranslated('PayandConfirm', context),
              //  getTranslated('placeyourbooking', context),
              style: TextStyle(
                fontFamily: 'Montserrat2',
                color: white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //PAY AND CONFIRM BOOKING
  payConfirmApiCall(String bookingId) async {
    Loader().showLoader(context);
    final ApprovedchargesbycustomerModel ispayconfirm =
        await _repository.oncustomerApprovedApi(bookingId);
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
                      Navigator.pop(context);
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

  Future<bool> acceptbookingApiCall(String jobNumber) async {
    Loader().showLoader(context);
    final ApproveJobCardModel? isapprovejobcard =
        await _repository.approveJobCardAPI(jobNumber);
    if (isapprovejobcard == null || isapprovejobcard.code != '0') {
      Loader().hideLoader(context);
      snackBar(isapprovejobcard!.message ?? 'Accept Booking');
      return true;
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isapprovejobcard.message != null ? isapprovejobcard.message! : '');
      return false;
    }
  }

  dynamic onSendNotificationAdminAPI() async {
    // show loader
    Loader().showLoader(context);
    final SendNotificationAdminModel isAdmin =
        await _repository.onSendNotificationAdminAPI('Payment Confirmed',
            'User has paid for All Tasks. Please start work and update when any work completed');
    Loader().hideLoader(context);
    if (isAdmin.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button for close dialog!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Successfully Paid'),
            content: const Text(
                'Admin has been notified that User had paid for all Work. You will be informed when all work will be completed. Thanks'),
            actions: [
              // FlatButton(
              //   child: const Text('CANCEL'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  // onSendNotificationAdminAPI();
                },
              )
            ],
          );
        },
      );
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
