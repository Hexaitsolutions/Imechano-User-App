// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapLocation extends StatefulWidget {
  final Function? callBackFunction;

  const MapLocation({Key? key, this.callBackFunction}) : super(key: key);
  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  int current_step = 0;
  LatLng? currentPosition;
  dynamic latitudeCurrentLocation;
  dynamic longtitudeCurrentLocation;
  bool mapLoad = false;
  bool loadAddress = false;

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      latitudeCurrentLocation = currentPosition!.latitude;
      longtitudeCurrentLocation = currentPosition!.longitude;
      setState(() {
        mapLoad = true;
      });
      marker();
    });
  }

  List<Placemark>? placemarks;
  List<Marker> _markers = <Marker>[];
  var area;
  var street;
  var area2;
  var city;
  var state;
  var country;
  var postalCode;
  var fullAddress;

  addressGet() {
    setState(() {
      area = placemarks![0].name;
      street = placemarks![0].street;
      area2 = placemarks![0].subLocality;
      city = placemarks![0].locality;
      state = placemarks![0].administrativeArea;
      country = placemarks![0].isoCountryCode;
      postalCode = placemarks![0].postalCode;
      fullAddress = '$street' +
          '$area' +
          '$area2' +
          '$city' +
          '$state' +
          '$country' +
          '$postalCode';
    });
  }

  GoogleMapController? mapsController;

  LatLng? middlePointOfScreenOnMap;

  marker() async {
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        draggable: true,
        onDragEnd: (value) async {
          latitudeCurrentLocation = value.latitude;
          longtitudeCurrentLocation = value.longitude;
          placemarks = await placemarkFromCoordinates(
              latitudeCurrentLocation, longtitudeCurrentLocation);
          addressGet();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
            'address',
            "${("$street, $area, $area2, $city, $state, $country, $postalCode")}",
          );

          prefs.setString(
            'lontitude',
            "$longtitudeCurrentLocation",
          );

          prefs.setString(
            'latitude',
            "$latitudeCurrentLocation",
          );
          widget.callBackFunction!(true);

          print("$longtitudeCurrentLocation   data set");
        },
        position: LatLng(latitudeCurrentLocation, longtitudeCurrentLocation),
        infoWindow: InfoWindow(title: 'The title of the marker')));
    placemarks = await placemarkFromCoordinates(
        latitudeCurrentLocation, longtitudeCurrentLocation);
    addressGet();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'address',
      "${("$street, $area, $area2, $city, $state, $country, $postalCode")}",
    );

    prefs.setString(
      'lontitude',
      "$longtitudeCurrentLocation",
    );

    prefs.setString(
      'latitude',
      "$latitudeCurrentLocation",
    );

    if (postalCode != null) {
      setState(() {
        loadAddress = true;
      });
    }
    widget.callBackFunction!(true);
  }

  String? currentVisibleRegion;
  GoogleMapController? mapController;
  LatLngBounds _visibleRegion = LatLngBounds(
    southwest: const LatLng(0, 0),
    northeast: const LatLng(0, 0),
  );

  @override
  void initState() {
    super.initState();
    permissionCheck();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  permissionCheck() async {
    final status = await _handleLocationPermission();

    _handleLocationPermission();
    if (status == true) {
      _getUserLocation();
    } else {
      latitudeCurrentLocation = 19.0760;
      longtitudeCurrentLocation = 72.8777;
      setState(() {
        mapLoad = true;
      });
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  dynamic appModelTheme;

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);

    appModelTheme = appModel;

    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () {
          return WillPopScope(
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
                key: _key,
                drawer: drawerpage(),
                appBar: WidgetAppBar(
                  title: getTranslated('pickuplocation', context),
                  menuItem: 'assets/svg/Menu.svg',
                  imageicon: 'assets/svg/Arrow_alt_left.svg',
                  home: 'assets/svg/homeicon.svg',
                  //action2: 'assets/svg/ball.svg',
                ),
                body: Container(
                    child: Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0))),
                        child: mapLoad == true
                            ? GoogleMap(
                                markers: Set<Marker>.of(_markers),
                                myLocationButtonEnabled: true,
                                onCameraIdle: () async {
                                  var bounds =
                                      await mapsController!.getVisibleRegion();
                                  print(bounds);

                                  // LatLng center = LatLng(
                                  //   (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
                                  //   (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
                                  // );
                                  // print("${bounds}      0000");
                                  // final LatLngBounds visibleRegion =
                                  //     await mapController!.getVisibleRegion();
                                  // setState(() {
                                  //   _visibleRegion = visibleRegion;
                                  // });
                                },
                                onCameraMove: (position) async {},
                                myLocationEnabled: false,
                                zoomControlsEnabled: false,
                                mapType: MapType.hybrid,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(latitudeCurrentLocation,
                                      longtitudeCurrentLocation),
                                  zoom: 15,
                                ),
                                onMapCreated:
                                    (GoogleMapController controller) {},
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: appModelTheme.darkTheme
                                    ? darkmodeColor
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                    topLeft: Radius.circular(30.0))),
                            height: 200.h,
                            width: double.infinity,
                            child: Bottomsheet())
                      ],
                    )
                  ],
                ))),
          );
        });
  }

  Widget Bottomsheet() {
    return Column(
      children: [
        Divider(
          color: Colors.grey[300],
          height: 30.h,
          thickness: 5,
          indent: 90,
          endIndent: 90,
        ),
        Row(
          children: [
            SizedBox(
              width: 25.w,
            ),
            Container(
              width: 20.w,
              margin: EdgeInsets.only(bottom: 100.h),
              alignment: Alignment.centerLeft,
              child: Container(
                child: DottedBorder(
                  color: greycolo,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  padding: EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      height: 10,
                      width: 10,
                      child: Icon(Icons.circle, size: 9, color: greycolo),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8.0.w),
                  child: Text(
                    "Home",
                    style: TextStyle(fontFamily: "Poppins2"),
                  ),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(left: 8.0.w),
                    child: loadAddress == true
                        ? Text(
                            "${("$street, $area, $area2, $city, $state, $country, $postalCode")}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11.sp,
                                fontFamily: "Poppins1"),
                          )
                        : Text("Location Searching....")),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.0.w),
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.sp,
                        fontFamily: "Poppins1"),
                  ),
                ),
                Container(
                  height: 42.h,
                  width: 250.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Color(0xff70bdf1),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      'Confirm your Location',
                      style: TextStyle(
                          fontFamily: "Poppins1",
                          color: Colors.white,
                          fontSize: 16.sp),
                    ),
                    onPressed: () async {
                      String latLong = latitudeCurrentLocation.toString() +
                          '/' +
                          longtitudeCurrentLocation.toString() +
                          '/' +
                          fullAddress;
                      if (Navigator.of(context).canPop()) {
                        Navigator.pop(context, latLong);
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => BottomBarPage(2)),
                            (Route<dynamic> route) => false);
                      }

                      // Get.off(SignUpScreen());
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
