import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imechano/ui/modal/send_notification_admin_modal.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/My_Bookings_Page.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';

import 'package:provider/provider.dart';

class ReturnCarCheckOut extends StatefulWidget {
  @override
  _ReturnCarCheckOutState createState() => _ReturnCarCheckOutState();
}

class _ReturnCarCheckOutState extends State<ReturnCarCheckOut> {
  int _radioValue = 0;
  List _nameList = [];
  final _repository = Repository();
  dynamic appModelTheme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _nameList = selectedService!['item_name'];
  }

  @override
  Widget build(BuildContext context) {
    // _nameList = selectedService!['item_name'];

    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
        appBar: WidgetAppBar(
            title: 'Checkout',
            menuItem: 'assets/svg/Arrow_alt_left.svg',
            action2: 'assets/svg/ball.svg'),
        backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: appModelTheme.darkTheme ? darkmodeColor : white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0))),
                child: SingleChildScrollView(
                  child: _body(),
                ),
              ),
            ),
          ]),
        ));
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: appModelTheme.darkTheme ? darkmodeColor : white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            _delAddressTag(),
            _addressMap(),
            SizedBox(height: 15.h),
            _changeAddress(),
            SizedBox(height: 15.h),
            _addLocationComment(),
            SizedBox(height: 15.h),
            _customDivider(),
            // _changeOilTag(),
            SizedBox(height: 15.h),
            // _cardList(),
            _paymentMethod(),
            SizedBox(height: 15.h),
            methidOFtransaction(),
            _customDivider(),
            SizedBox(height: 15.h),
            _delChange(),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Divider(),
            ),
            SizedBox(height: 15.h),
            _delTotal(),
            SizedBox(height: 15.h),
            _placeBookingbutton()
          ],
        ),
      ),
    );
  }

  Widget _cardList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _nameList.length,
      itemBuilder: (context, index) {
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
                  padding: EdgeInsets.only(
                    left: 23,
                  ),
                  child: Text(
                    '${_nameList[index]}',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins1',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 10,
                        color: presenting,
                      ),
                      SizedBox(width: 2.w),
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
                        '250 Ratings',
                        style: TextStyle(
                          fontSize: 10,
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
                        size: 7,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Takes 4 Hour',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins3',
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
                        size: 7,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Every 6 Months or 5000 kms',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins3',
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
                        size: 7,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        // ========================by jenish==========================
                        'Alignment & Balancing Included',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Poppins3',
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
                          fontSize: 10,
                          fontFamily: 'Poppins3',
                        ),
                      ),
                    ],
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

  Widget _delAddressTag() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text('Delievery Address',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: 'Poppins2',
          )),
    );
  }

  Widget _addressMap() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 100.h,
        width: 500.w,
        child: Image.asset(
          'assets/images/google_picture.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  // Widget _changeOilTag() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 27),
  //     child: Text(catogoryName!,
  //         style: TextStyle(
  //           fontSize: 15,
  //           fontFamily: 'Poppins1',
  //         )),
  //   );
  // }

  Widget _changeAddress() {
    return Row(
      children: [
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            '653, Nostrannd Ave, Brokyn NY 21116',
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Poppins1',
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 68),
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: red,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: red,
                    fontFamily: 'Poppins1',
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        )
      ],
    );
  }

  Widget _addLocationComment() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appModelTheme.darkTheme
              ? grayE6E6E5.withOpacity(0.1)
              : apptransbackcolor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.location_on,
                color: appModelTheme.darkTheme ? logoBlue : buttonBlue3b5999,
                size: 30.h,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              'Additional Location Comment.....',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Poppins1',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customDivider() {
    return Divider(
      thickness: 10,
      color: appModelTheme.darkTheme
          ? grayE6E6E5.withOpacity(0.1)
          : apptransbackcolor,
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
              'Payment method',
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Poppins2',
              ),
            ),
          ),
          SizedBox(width: 10.sp),
          InkWell(
              onTap: () {},
              child: Container(
                child: Text(
                  '+ Add Card',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: red,
                    fontFamily: 'Poppins1',
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget methidOFtransaction() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 43.h,
            decoration: BoxDecoration(
              color: appModelTheme.darkTheme
                  ? grayE6E6E5.withOpacity(0.1)
                  : apptransbackcolor,
              border: Border.all(
                color: apptransbackcolor,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Container(
                    child: Text(
                      'Pay On Delivery(POS Machine)',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins1',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 60, right: 5),
                  child: Container(
                    height: 20.h,
                    width: 20.w,
                    child: Radio(
                      value: 0,
                      groupValue: _radioValue,
                      activeColor: logoBlue,
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13.h),
          Container(
            height: 43.h,
            decoration: BoxDecoration(
              color: appModelTheme.darkTheme
                  ? grayE6E6E5.withOpacity(0.1)
                  : apptransbackcolor,
              border: Border.all(
                color: apptransbackcolor,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    child: Text(
                      'VISA **** **** **** 2187',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Poppins1',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 114, right: 5),
                  child: Container(
                    height: 20.h,
                    width: 20.w,
                    child: Radio(
                      value: 1,
                      groupValue: _radioValue,
                      activeColor: logoBlue,
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13.h),
        ],
      ),
    );
  }

  Widget _delChange() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Please confirm by paying',
              style: TextStyle(
                fontFamily: 'Poppins1',
              ),
            ),
            SizedBox(
              width: 50.w,
            ),
            Text(
              'KWD 4.0000',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'Poppins2',
                color: red,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '75% of the balance Amount',
              style: TextStyle(
                fontFamily: 'Poppins1',
              ),
            ),
            SizedBox(
              width: 80.w,
            ),
            Text(
              'KWD 2',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'Poppins2',
                color: red,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _delTotal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Total',
          style: TextStyle(
            fontFamily: 'Poppins2',
          ),
        ),
        SizedBox(
          width: 120.w,
        ),
        Text(
          'KWD 4.020',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontFamily: 'Poppins2',
            color: red,
          ),
        ),
      ],
    );
  }

  Widget _placeBookingbutton() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          Get.to(MyBookingsPage());
          // onSendNotificationAdminAPI();
        },
        child: Container(
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: logoBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Confirm Delivery',
              style: TextStyle(
                fontFamily: 'Poppins1',
                color: white,
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic onSendNotificationAdminAPI() async {
    // show loader
    Loader().showLoader(context);
    final SendNotificationAdminModel isAdmin = await _repository
        .onSendNotificationAdminAPI('Confirm Delivery complete', 'message');

    if (isAdmin.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      Loader().hideLoader(context);
      Get.to(MyBookingsPage());
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
