// ignore_for_file: unused_element, non_constant_identifier_names, unused_field, deprecated_member_use

import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/modal/booking_list_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/pickup_condition_list_bloc.dart';
import '../../modal/pickup_conditions_list_model.dart';
import '../../styling/config.dart';

class BookingListShow extends StatefulWidget {
  final ItemData data;
  final String? carName;
  final String? booking;
  final String? appointment;

  final String? bookingid;
  const BookingListShow(
      {Key? key,
      required this.data,
      this.bookingid,
      this.carName,
      this.booking,
      this.appointment})
      : super(key: key);

  @override
  _BookingListShowState createState() => _BookingListShowState();
}

class _BookingListShowState extends State<BookingListShow>
    with WidgetsBindingObserver {
  List<Color> clr = [
    Color(0xff3b5999),
    Color(0xffff0000),
    Color(0xff162e3f),
    Color(0xff687fb0),
    Color(0xff162E3F)
  ];
  DateTime _selectedValue = DateTime.now();
  DateTime _dateTime = DateTime.now();
  double hh = 0;
  double ww = 0;
  List _nameList = [];
  bool listHaveData = false;
  dynamic appModelTheme;
  GlobalKey previewContainer = GlobalKey();
  var grossTotal = 0.00;
  // Create a NumberFormat instance for formatting
  var numberFormat = NumberFormat('#,##0.00', 'en_US');
  String formattedGrossTotal = '';

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    getAddress();
    getTotal();
    pickupConditionsListBloc
        .pickupConditionsListSink(widget.bookingid.toString());
    dynamicBottomCard();
  }

  getTotal() {
    var total = widget.data.total;
    var deliveryCharges = widget.data.deliveryCharges;
    if (total != null && deliveryCharges != null) {
      grossTotal = ((double.tryParse(total) ?? 0.00) +
          (double.tryParse(deliveryCharges) ?? 0.00));

      // Format the grossTotal value with commas and two decimal places
      formattedGrossTotal = numberFormat.format(grossTotal);
    }
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

  var address;

  getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('address') ?? 'Select your address';
    });
  }

  @override
  Widget build(BuildContext context) {
    hh = MediaQuery.of(context).size.height;
    ww = MediaQuery.of(context).size.width;

    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomBarPage(1)),
              (Route<dynamic> route) => false);
        }
        return true;
      },
      child: WillPopScope(
        onWillPop: () async {
          if (Navigator.of(context).canPop()) {
            Navigator.pop(context);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => BottomBarPage(2)),
                (Route<dynamic> route) => false);
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Color(0xff70BDF1),
          appBar: WidgetAppBar(
            title: getTranslated('BookingDetails', context),
            imageicon: 'assets/svg/Arrow_alt_left.svg',
            action2: 'assets/svg/ball.svg',
          ),
          body: RepaintBoundary(
            key: previewContainer,
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: appModelTheme.darkTheme ? Color(0xff252525) : white,
              ),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _body,
                    ],
                  ),
                ),
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     // Take screenshot

          //     RenderRepaintBoundary boundary = previewContainer.currentContext!
          //         .findRenderObject() as RenderRepaintBoundary;
          //     var image = await boundary.toImage(pixelRatio: 2.0);
          //     var byteData =
          //         await image.toByteData(format: ImageByteFormat.png);
          //     Uint8List imageBytes = byteData!.buffer.asUint8List();

          //     String? path = await FlutterNativeScreenshot.takeScreenshot();
          //     final file = File(path!);
          //     OpenFile.open(file.path);

          //     // Uint8List image = file.readAsBytesSync();
          //     // Generate PDF
          //     Image.file(file);
          //     final pdf = pw.Document();
          //     final imageProvider = pw.MemoryImage(imageBytes);
          //     pdf.addPage(
          //       pw.Page(
          //         build: (pw.Context context) {
          //           return pw.Center(
          //             child: pw.Image(imageProvider),
          //           );
          //         },
          //       ),
          //     );

          //     // Save PDF to device
          //     final directory = await getExternalStorageDirectory();
          //     final downloadsDirectory =
          //         Directory('${directory!.path}/Download');
          //     await downloadsDirectory.create(recursive: true);
          //     final file1 = File('${downloadsDirectory.path}/example.pdf');
          //     await file1.writeAsBytes(await pdf.save());
          //     await OpenFile.open('${directory.path}/example.pdf');
          //   },
          //   child: Icon(Icons.save),
          // ),
        ),
      ),
    );
  }

  Widget get _body {
    log(widget.bookingid.toString());
    log(widget.carName.toString());
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          _carTag(),

          _carCard(),
          SizedBox(height: 15),

          _changeOilTag(),
          // SizedBox(height: 5),
          _cardList(),
          SizedBox(height: 15),
          _delChange(),
          SizedBox(height: 15),
          _customDivider(),
          SizedBox(height: 15),
          _delTotal(),
          SizedBox(height: 15),
          dynamicBottomCard(),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  // Center _carDetails() {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           getTranslated('bookingid', context) +
  //               " : " +
  //               widget.data.bookingId.toString(),
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontFamily: 'Poppins1',
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           getTranslated('car', context) +
  //               " : " +
  //               widget.data.carName.toString(),
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontFamily: 'Poppins1',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _topImage() {
    return Container(
      height: 130,
      width: double.infinity,
      child: Padding(
        //========================by jenish ==================
        padding: const EdgeInsets.only(left: 20, right: 7),
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: clr[index],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        width: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Container(
                                  height: 20,
                                  width: 100,
                                  child: Center(
                                      // ==============================by jenish==============================

                                      child: Text(
                                    'PRESENTING',
                                    style: TextStyle(
                                        //  =========================by jenish==================================
                                        color: white,
                                        fontSize: 10,
                                        fontFamily: 'CourierPrime1'),
                                  )),
                                  decoration: BoxDecoration(
                                      color: presenting,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                //============================================by jenish===========================
                                'SUPERIOR GRIP FOR EVERY TRIP',
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Verdana1'),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                //===============================================by jenish============================
                                SizedBox(width: 20),
                                Text(
                                  'A long way Together',
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 10,
                                      fontFamily: 'Poppins3'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/tyre-img.png',
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _delAddressTag() {
    return Padding(
      //=======================by jenish=========================
      padding: const EdgeInsets.only(left: 27),
      child: Text('Delievery Address',
          style: TextStyle(
            //=================================by jenish========================
            fontSize: 15,
            fontFamily: 'Poppins1',
          )),
    );
  }

  Widget _addressMap() {
    return Padding(
      padding: EdgeInsets.only(left: 27, top: 15, right: 20),
      child: Container(
        height: 100,
        width: 500,
        child: Image.asset(
          'assets/images/google_picture.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _changeAddress() {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.data.address!,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins1',
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

  Widget _changeOilTag() {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 27),
      child: Text(
          getTranslated('Selected', context) +
              " " +
              getTranslated('Service', context),
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins1',
          )),
    );
  }

  Widget _carTag() {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 27),
      child: Text(
        getTranslated('BookingDetails', context),
        style: TextStyle(
          fontSize: 15,
          // fontWeight: FontWeight.w700,
          fontFamily: 'Poppins1',
        ),
      ),
    );
  }

  Widget _addLocationComment() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 18),
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: appModelTheme.darkTheme ? darkmodeColor : Color(0xffE6E6E5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Additional Location Comment.....',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Poppins3',
                ),
              )
            ],
          )),
    );
  }

  Widget _carCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 20, bottom: 15, top: 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: appModelTheme.darkTheme ? darkmodeColor : white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: appModelTheme.darkTheme
                    ? black
                    : Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(ww * 0.05, hh * 0.01, ww * 0.03, hh * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated('bookingid', context) +
                    " : " +
                    widget.data.bookingId.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins1',
                ),
              ),
              SizedBox(height: 8),
              Text(
                getTranslated('car', context) +
                    " : " +
                    widget.data.carName.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins1',
                ),
              ),
              SizedBox(height: 8),
              Text(
                getTranslated('AppointmentTime', context) +
                    " : " +
                    widget.data.timeDate.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins1',
                ),
              ),
              SizedBox(height: 8),
              Text(
                getTranslated('BookingTime', context) +
                    " : " +
                    widget.data.bookingTime.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins1',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.data.items?.length,
      itemBuilder: (context, index) {
        String formattedPrice = '0.00';
        var price = widget.data.items![index].price;
        if (price != null) {
          var p = double.tryParse(price) ?? 0.00;
          formattedPrice = numberFormat.format(p);
        }

        return Padding(
          padding:
              const EdgeInsets.only(left: 26, right: 20, bottom: 15, top: 15),
          child: Container(
            decoration: BoxDecoration(
                color: appModelTheme.darkTheme ? darkmodeColor : white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: appModelTheme.darkTheme
                        ? black
                        : Colors.grey.withOpacity(0.2),
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
                  padding: EdgeInsets.fromLTRB(
                      ww * 0.05, hh * 0.01, ww * 0.03, hh * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.data.items![index].subCategoryId == "10013"
                          ? Text(
                              widget
                                  .data.items![index].item!.removeAllWhitespace,
                              style: TextStyle(
                                fontFamily: 'Poppins1',
                              ),
                            )
                          : Text(
                              getTranslated(
                                  widget.data.items![index].item!
                                      .removeAllWhitespace,
                                  context),
                              style: TextStyle(
                                fontFamily: 'Poppins1',
                              ),
                            ),
                      Text('$formattedPrice',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 10,
                        color: presenting,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '4.5',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins1',
                          color: presenting,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        getTranslated('250Ratings', context),
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins3',
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),

                // ========================by jenish==========================

                Padding(
                  padding: EdgeInsets.only(left: 17, right: 17, top: 15),
                  child: Text(
                    '${widget.data.timeDate.toString()}',
                    // DateFormat('hh:mm a dd-MM-yy')
                    //     .format(DateTime.parse(widget.data.updatedAt!)),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins1',
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
            getTranslated('deliverycharges', context),
            // ========================by jenish==========================
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins1',
            ),
          ),
          // ========================by jenish==========================
          Text(
            widget.data.deliveryCharges == null
                ? getTranslated("qr", context) + ' 0.00'
                : widget.data.deliveryCharges!.isEmpty
                    ? getTranslated("qr", context) + ' 0.00'
                    : getTranslated("qr", context) +
                        ' ${widget.data.deliveryCharges}.00',
            //getTranslated('qr', context)!,
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

  Widget _customDivider() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Divider(
        color: appModelTheme.darkTheme ? white : Colors.black38,
      ),
    );
  }

  Widget _delTotal() {
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
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins1',
            ),
          ),
          Text(
            // ========================by jenish==========================
            // 'KWD ${widget.selectedService['total']}',
            widget.data.total == null
                ? getTranslated("qr", context) + ' 0.00'
                : widget.data.total!.isEmpty
                    ? getTranslated("qr", context) + ' 0.00'
                    : getTranslated("qr", context) + '$formattedGrossTotal',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins2',
              color: black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookAppoinment() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 20),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(20),
              child: Container(
                height: hh * 0.57,
                child: _DateTime(),
              ),
            ),
          );
        },
        child: Container(
          height: 48,
          width: 380,
          decoration: BoxDecoration(
            color: logoBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '3 Services Selected',
                style: TextStyle(
                  fontFamily: 'Poppins1',
                  color: white,
                  fontSize: 10,
                ),
              ),
              Text(
                'Book Apointment',
                style: TextStyle(
                  fontFamily: 'Poppins1',
                  color: white,
                  fontSize: 15,
                ),
              ),
              Icon(
                Icons.shopping_cart,
                color: white,
              )
            ],
          ),
        ),
      ),
    );
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
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(getTranslated('selectdateandtime', context),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins1')),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Center(
                    child: DatePicker(
                      DateTime.now(),
                      height: hh * 0.13,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: appModelTheme.darkTheme
                          ? darkmodeColor
                          : Colors.transparent,
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all()),
                  padding:
                      EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins3',
                        color: appModelTheme.darkTheme ? white : Colors.black),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    snackBar('Appoinment Successfully!!');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 10, bottom: 10),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Poppins3'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget Time() {
    return Container(
      height: hh * 0.25,
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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget dynamicBottomCard() {
    return StreamBuilder<PickupConditionsListModel>(
        stream: pickupConditionsListBloc.ConditionsListStream,
        builder: (context,
            AsyncSnapshot<PickupConditionsListModel> conditionsListsnapshort) {
          if (!conditionsListsnapshort.hasData) {
            listHaveData = false;
            return Center(
                child: conditionsListsnapshort.data == null
                    ? CircularProgressIndicator()
                    : Text(
                        'No Data Found',
                        style: TextStyle(fontFamily: 'Poppins1', fontSize: 18),
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
                    listHaveData = true;
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
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
              style: TextStyle(fontFamily: "Poppins1", fontSize: 15),
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

      return Row(
        children: [
          for (int i = 0; i < values.length - 1; i++)
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey,
                        child: Image.network(
                          Config.imageurl + values[i]!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: Image.network(
                  Config.imageurl + values[i]!,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
        ],
      );
    } else {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey,
                  child: Image.network(
                    Config.imageurl + images,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            Config.imageurl + images,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    }
  }

  Widget bottomCard(String carCondition, String workNeeded) {
    return Expanded(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Pickup Condition",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text("$carCondition",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: cardgreycolor2,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              "Type of Work Needed",
              style: TextStyle(
                  color: greycolorfont, fontSize: 9, fontFamily: "Poppins3"),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 5),
              child: Text("$workNeeded",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: "Poppins3")),
            ),
          ),
        ),
      ],
    ));
  }

  void onResumed() {
    print("~~~~~~~ resumed");
    setState(() {
      dynamicBottomCard();
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
}
