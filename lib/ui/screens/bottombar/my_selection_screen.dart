// ignore_for_file: unused_field, non_constant_identifier_names
import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:imechano/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/common/globals.dart' as globals;
import 'package:imechano/ui/modal/car_booking_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/location/location_map.dart';
import 'package:imechano/ui/screens/my_account/home.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySelectionPage extends StatefulWidget {
  final Map selectedService;
  final String categoryName;
  final String categoryId;

  int currentCount;

  MySelectionPage({
    required this.selectedService,
    required this.categoryName,
    required this.categoryId,
    required this.currentCount,
  });

  @override
  _MySelectionPageState createState() => _MySelectionPageState();
}

class _MySelectionPageState extends State<MySelectionPage>
    with WidgetsBindingObserver {
  List<Color> clr = [
    Color(0xff3b5999),
    Color(0xffff0000),
    Color(0xff162e3f),
    Color(0xff687fb0),
    Color(0xff162E3F)
  ];
  DateTime _selectedValue = DateTime.now();
  // DateTime _dateTime = DateTime.now();
  double hh = 0;
  double ww = 0;
  List _nameList = [];
  final _repository = Repository();
  var priceTotal = 0;
  dynamic appModelTheme;
  List<Marker> _markers = <Marker>[];
  final userStr =
      PrefObj.preferences!.containsKey(PrefKeys.USER_DATA) ? true : false;

  SharedPreferences? prefs;

  marker() async {
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(double.parse(lat), double.parse(long)),
        infoWindow: InfoWindow(title: 'The title of the marker')));
  }

  @override
  void initState() {
    super.initState();
    log('my_selection_screen');
    print("hello");
    print("Screen Selection INIT1");
    BackButtonInterceptor.add(myInterceptor);

    if (widget.selectedService['item_name'] != null) {
      _nameList = widget.selectedService['item_name'];
    }

    getAddress();
    WidgetsBinding.instance!.addObserver(this);
  }

  var numberFormat = NumberFormat('#,##0.00', 'en_US');
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("sfasfasa");
    if (!Navigator.canPop(context)) {
      // If there is a previous screen, pop it off the stack
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBarPage(2),
        ),
      );
    } else {
      Navigator.pop(context, 'refresh');
    }

    if (stopDefaultButtonEvent) {
      print("I m press");
      // Perform any custom logic you need here
      Navigator.pop(context, 'refresh');
    }
    return false;
  }

  // In page 2
  @override
  void dispose() {
    print('page 2 disposed');
    BackButtonInterceptor.remove(myInterceptor);

    super.dispose();
  }

  bool loadMap = false;
  var address;
  dynamic lat = 0.obs;
  dynamic long;
  List<dynamic> uniqueNames = [];
  List<dynamic> itemPrices = [];
  List<dynamic> uniqueSubCatogories = [];
  List<Map<String, dynamic>> itemNames = [];

  @override
  void didUpdateWidget(MySelectionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (MySelectionPage != MySelectionPage) {
      print("yes bbbb");
    } else {
      print(" no bbbbb");
    }
  }

  getAddress() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs!.getString('address') ?? 'Select your address';
      long = prefs!.getString('lontitude') ?? '0.00';
      lat = prefs!.getString('latitude') ?? '0.00';

      loadMap = true;
    });
    marker();
  }

  @override
  Widget build(BuildContext context) {
    print("RARARARARA");
    if (globals.cart.isEmpty != true) {
      List<int> intList = globals.cart
          .where((element) => element['price'] != "")
          .toList()
          .map((item) => item['price'])
          .toList()
          .map((str) => int.parse(str))
          .toList();

      priceTotal = intList.sum;
    }

    itemNames = [];
    itemPrices = [];

    globals.itemId = globals.cart.map((item) => item['itemId']).toList();
    globals.itemName = globals.cart.map((item) => item['ItemName']).toList();
    itemPrices = globals.cart.map((item) => item['price']).toList();

    uniqueNames = globals.cart.map((item) => item['name']).toSet().toList();

    //log('Unique names: $uniqueNames');
    log('Item prices: $itemPrices');
    hh = MediaQuery.of(context).size.height;
    ww = MediaQuery.of(context).size.width;

    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
      drawer: drawerpage(),
      backgroundColor: Color(0xff70BDF1),
      appBar: WidgetAppBar(
        title: getTranslated('myselections', context),
        menuItem: 'assets/svg/Menu.svg',
        // imageicon: 'assets/svg/Arrow_alt_left.svg',
        home: 'assets/svg/homeicon.svg',
        action2: 'assets/svg/ball.svg',
        flag: false,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        height: hh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: appModelTheme.darkTheme ? Color(0xff252525) : white,
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
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
    );
  }

  Widget get _body {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          _topImage(),
          SizedBox(height: 15),
          _delAddressTag(),
          Container(
              margin: EdgeInsets.only(
                  left: ww * 0.08,
                  right: ww * 0.08,
                  top: hh * 0.01,
                  bottom: hh * 0.01),
              height: MediaQuery.of(context).size.height * 0.11,
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
          SizedBox(height: 15),
          _changeAddress(),
          SizedBox(height: 15),
          _addLocationComment(),
          SizedBox(height: 15),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: uniqueNames.length,
              itemBuilder: (context, innerIndex) {
                uniqueSubCatogories = globals.cart
                    .where((item) => item["name"] == uniqueNames[innerIndex])
                    .map((item) => item["sub_catogory"])
                    .toList();

                uniqueSubCatogories = uniqueSubCatogories.toSet().toList();
                //log('Unique subcategories: ${uniqueSubCatogories.toString()}');
                return Column(
                  children: [
                    _changeOilTag(innerIndex),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: uniqueSubCatogories.length,
                        itemBuilder: (context, innerIndex) {
                          itemNames.insert(innerIndex, {
                            "catogory_name": uniqueSubCatogories[innerIndex],
                            "item_name": globals.cart
                                .where((item) =>
                                    item["sub_catogory"] ==
                                    uniqueSubCatogories[innerIndex])
                                .map((item) => item["ItemName"])
                                .toList(),
                            "item_price": globals.cart
                                .where((item) =>
                                    item["sub_catogory"] ==
                                    uniqueSubCatogories[innerIndex])
                                .map((item) => item["price"])
                                .toList(),
                          });
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                    getTranslated(
                                        uniqueSubCatogories[innerIndex]
                                            .toString()
                                            .removeAllWhitespace,
                                        context),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height: 15),
                              _cardList(uniqueSubCatogories[innerIndex]),
                            ],
                          );
                        })
                  ],
                );
              }),

          // SizedBox(height: 15),
          // _delChange(),
          SizedBox(height: 15),
          _customDivider(),

          SizedBox(height: 15),
          _delTotal(),
          SizedBox(height: 15),
          _bookAppoinment(),
          SizedBox(height: 15),
        ],
      ),
    );
  }

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
            // priceTotal = widget.selectedService['total'] + 20;

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
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
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
                                SizedBox(width: 20.w),
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
      padding: const EdgeInsets.only(left: 27, right: 27),
      child: Text(getTranslated('deliveryaddress', context),
          style: TextStyle(
            //=================================by jenish========================
            fontSize: 15,
            fontFamily: 'Poppins1',
          )),
    );
  }

  Widget _changeAddress() {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
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
                setState(() {});

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MapLocation(
                      callBackFunction: (mainAddress) {
                        _markers = <Marker>[];
                        getAddress();

                        setState(() {});
                      },
                    );
                  },
                ));
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

  Widget _changeOilTag(int index) {
    //log('INSIDE CHANGE OIL TAG, UNIQUE NAMES: ${uniqueNames[index].toString().removeAllWhitespace.toString()}');
    return Padding(
      padding: const EdgeInsets.only(left: 27),
      child: Text(
          getTranslated(
              uniqueNames[index].toString().removeAllWhitespace, context),
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins1',
          )),
    );
  }

  Widget _addLocationComment() {
    return Container(
        padding: EdgeInsets.only(left: 15.h),
        margin: EdgeInsets.only(left: ww * 0.07, right: ww * 0.05),
        width: double.infinity,
        height: hh * 0.06,
        decoration: BoxDecoration(
          color: appModelTheme.darkTheme ? darkmodeColor : Color(0xffE6E6E5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.blue,
              size: 20,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 15.h),
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
              ),
            ))
          ],
        ));
  }

  Widget _cardList(String catogory_name) {
    log('ITEM NAMES: $itemNames');
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemNames
          .where((item) => item["catogory_name"] == catogory_name)
          .map((item) => item["item_name"])
          .expand((i) => i)
          .toSet()
          .toList()
          .length,
      itemBuilder: (context, index) {
        // log('ITEMS: $itemNames');
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              // print("Shoaib Raja");
              // print(globals.sselected
              //     .where((item) =>
              //         item["catogory_name"] == catogory_name)
              //     .toList()[0]['selected']);

              // print("Curremt Index");

              // print(catogory_name);
              // print(globals.cart
              //     .where((item) =>
              //         item["sub_catogory"] == catogory_name)
              //     .map((item) => item["Index"])
              //     .toList()[0][index]);

              // print("List Index");
              // print(index);

              // print("Curremt Index - Legal");

              // print(globals.cart
              //     .where((item) =>
              //         item["sub_catogory"] == catogory_name)
              //     .first['Index'][index]);

              // print("Card");

              // print(globals.cart
              //     .where((item) =>
              //         item["sub_catogory"] == catogory_name)
              //     .first['Index']);

              // globals.sselected
              //         .where(
              //             (item) =>
              //                 item["catogory_name"] ==
              //                 catogory_name)
              //         .toList()[0]['selected'][
              //     globals.cart
              //         .where((item) =>
              //             item["sub_catogory"] == catogory_name)
              //         .map((item) => item["Index"])
              //         .toList()[0][index]] = false;

              // globals.cart
              //     .where((item) =>
              //         item["sub_catogory"] == catogory_name)
              //     .first['Index']
              //     .remove(globals.cart
              //         .where((item) =>
              //             item["sub_catogory"] == catogory_name)
              //         .map((item) => item["Index"])
              //         .toList()[0][index]);

              // globals.cart.removeWhere((service) =>
              //     service["ItemName"] ==
              //     itemNames
              //         .where((item) =>
              //             item["catogory_name"] ==
              //             catogory_name)
              //         .map((item) => item["item_name"])
              //         .expand((i) => i)
              //         .toSet()
              //         .toList()[index]);
              // globals.currentCount = globals.currentCount - 1;

              globals.currentCount = globals.currentCount - 1;

              globals.sselected
                      .where((item) => item["catogory_name"] == catogory_name)
                      .toList()[0]['selected'][
                  globals.cart
                      .where((item) => item["sub_catogory"] == catogory_name)
                      .map((item) => item["Index"])
                      .toList()[0][index]] = false;

              // Remvoing it from Cart

              globals.cart.removeWhere((service) =>
                  service["ItemName"] ==
                  itemNames
                      .where((item) => item["catogory_name"] == catogory_name)
                      .map((item) => item["item_name"])
                      .expand((i) => i)
                      .toSet()
                      .toList()[index]);

//--------------------------------------------------------

              globals.cart
                  .where((item) => item["sub_catogory"] == catogory_name)
                  .first['Index']
                  .remove(globals.cart
                      .where((item) => item["sub_catogory"] == catogory_name)
                      .map((item) => item["Index"])
                      .toList()[0][index]);
            });
          },
          child: Padding(
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
                    padding: EdgeInsets.only(left: 23, right: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        catogory_name == "Other"
                            ? Text(
                                itemNames
                                    .where((item) =>
                                        item["catogory_name"] == catogory_name)
                                    .map((item) => item["item_name"])
                                    .expand((i) => i)
                                    .toSet()
                                    .toList()[index]
                                    .toString()
                                    .removeAllWhitespace,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins1',
                                ),
                              )
                            : Text(
                                getTranslated(
                                    itemNames
                                        .where((item) =>
                                            item["catogory_name"] ==
                                            catogory_name)
                                        .map((item) => item["item_name"])
                                        .expand((i) => i)
                                        .toSet()
                                        .toList()[index]
                                        .toString()
                                        .removeAllWhitespace,
                                    context),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins1',
                                ),
                              ),
                        Row(
                          children: [
                            Text(
                              itemNames
                                  .where((item) =>
                                      item["catogory_name"] == catogory_name)
                                  .expand((item) => item["item_price"])
                                  .toList()[index]
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'Poppins1',
                              ),
                            ),
                            SizedBox(width: ww * 0.02),
                            GestureDetector(
                              onTap: () {
                                if (globals.currentCount >= 0) {
                                  log('Remove item from my selections');

                                  globals.currentCount =
                                      globals.currentCount - 1;

                                  globals.sselected
                                          .where((item) =>
                                              item["catogory_name"] ==
                                              catogory_name)
                                          .toList()[0]['selected'][
                                      globals.cart
                                          .where((item) =>
                                              item["sub_catogory"] ==
                                              catogory_name)
                                          .map((item) => item["Index"])
                                          .toList()[0][index]] = false;

                                  // Remvoing it from Cart
                                  globals.cart
                                      .where((item) =>
                                          item["sub_catogory"] == catogory_name)
                                      .first['Index']
                                      .remove(globals.cart
                                          .where((item) =>
                                              item["sub_catogory"] ==
                                              catogory_name)
                                          .map((item) => item["Index"])
                                          .toList()[0][index]);
                                  globals.cart.removeWhere((service) =>
                                      service["ItemName"] ==
                                      itemNames
                                          .where((item) =>
                                              item["catogory_name"] ==
                                              catogory_name)
                                          .map((item) => item["item_name"])
                                          .expand((i) => i)
                                          .toSet()
                                          .toList()[index]);

                                  // print(globals.cart
                                  //     .where((item) =>
                                  //         item["sub_catogory"] == catogory_name)
                                  //     .first['Index']);

                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.remove_circle,
                                  size: ww * 0.05,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
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

                  // ========================by jenish==========================

                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
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
    String total = numberFormat.format(int.tryParse('$priceTotal') ?? 0);
    return Padding(
      // ========================by jenish==========================
      padding: const EdgeInsets.only(left: 27, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // ========================by jenish==========================
            getTranslated('Total', context),
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins1',
            ),
          ),
          Text(
            // ========================by jenish==========================
            getTranslated("qr", context) + ' $total',
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

  Widget _bookAppoinment() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 20),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (globals.cart.isEmpty) {
            Fluttertoast.showToast(
                msg: "Please Select Service",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (address.contains('Select your address')) {
            Fluttertoast.showToast(
                msg: getTranslated('Selectyouraddressfirst', context),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            _selectedValue = DateTime.now();
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
        },
        child: Container(
          height: 48,
          width: 380.w,
          decoration: BoxDecoration(
            color: logoBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${globals.currentCount} " +
                    getTranslated("Selected", context) +
                    " " +
                    getTranslated('Service', context),
                style: TextStyle(
                  fontFamily: 'Poppins1',
                  color: white,
                  fontSize: 10,
                ),
              ),
              Text(
                getTranslated('BookApointment', context),
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
            SizedBox(height: 10.h),
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
                      getTranslated('Cancel', context),
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins3',
                          color:
                              appModelTheme.darkTheme ? white : Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
                GestureDetector(
                  onTap: () async {
                    //log(_selectedValue.toString());
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
                    } else {
                      userStr
                          ? await callCarBookingAPI()
                          : showsuccessfullyToastMessage();

                      globals.itemId = [];
                      globals.itemName = [];
                      globals.currentCount = 0;
                      globals.selectedService = {};
                      globals.catogoryName = "";
                      globals.sselected = [];
                      globals.cart = [];
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
              ],
            ),
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
          setState(() {
            _selectedValue = datetime;
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

  dynamic callCarBookingAPI() async {
    bool isCarAdded = PrefObj.preferences!.containsKey(PrefKeys.CARID);
    // log("ITEMMM in Selection");
    print(widget.selectedService['item_id']
        .toString()
        .split('[')[1]
        .split(']')[0]);

    // show loader
    if (isCarAdded) {
      String itemId = globals.itemId.toString().split('[')[1].split(']')[0];
      // show loader
      Loader().showLoader(context);

      // log("ID in Selection");
      print(widget.selectedService);

      final CarBookingModal? isCarBooked = await _repository.carbookingAPI(
        widget.selectedService['customer_id'],
        widget.categoryId,
        widget.selectedService['sub_category_id'],
        itemId, //[23,4,5,6,7,8,9,0]
        // DateFormat('yyyy/MM/dd h:mm a').format(_selectedValue),
        DateFormat('yyyy/MM/dd kk:mm').format(_selectedValue),
        address,
        widget.selectedService['total'].toString(),
        PrefObj.preferences!.get(PrefKeys.CARID),
      );

      //log("STATUS OF API ");
      // print(isCarBooked?.code);

      if (isCarBooked?.code != '0') {
        FocusScope.of(context).requestFocus(FocusNode());
        Loader().hideLoader(context);
        currentBookingTab = 0;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomBarPage(1)),
            (value) => false);

        Fluttertoast.showToast(
            msg: isCarBooked!.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.lightBlueAccent,
            textColor: Colors.white,
            fontSize: 16.0);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isCarBooked.message!),
            duration: Duration(seconds: 1),
          ),
        )..closed.then((val) {
            if (val == SnackBarClosedReason.timeout) {
              currentBookingTab = 0;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomBarPage(1)),
                  (value) => false);
            }
          });
      } else {
        Loader().hideLoader(context);
        showpopDialog(context, 'Error',
            isCarBooked!.message != null ? isCarBooked.message! : '');
      }
    } else {
      userStr
          ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            )
          : Container();
      snackBar('Please Add Car First');
    }
  }

  Future<bool?> showsuccessfullyToastMessage() {
    return Fluttertoast.showToast(
        msg: "Please add your account",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
