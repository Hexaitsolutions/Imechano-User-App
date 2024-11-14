// ignore_for_file: non_constant_identifier_names
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/common/globals.dart';

import 'package:imechano/ui/provider/theme_provider.dart';

import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:imechano/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modal/car_booking_model.dart';
import '../../repository/repository.dart';
import '../../share_preferences/pref_key.dart';
import '../../share_preferences/preference.dart';
import '../location/location_map.dart';
import 'bottom_bar.dart';

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  var address;
  dynamic appModelTheme;
  var carid;
  //DateTime _dateTime = DateTime.now();
  double hh = 0;

  List<XFile>? imagefiles = <XFile>[];
  bool isCarAdded = false;
  dynamic lat = 0.obs;
  bool loadMap = false;
  dynamic long;
  SharedPreferences? prefs;
  XFile? image, temp;
  final userStr = PrefObj.preferences!.get(PrefKeys.USER_ID);
  TextEditingController workdoneController = TextEditingController();
  double ww = 0;

  List<Marker> _markers = <Marker>[];
  final ImagePicker _picker = ImagePicker();
  final _repository = Repository();
  // ignore: unused_field
  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
    imagefiles = null;
    workdoneController.text = "";
    isCarAdded =
        PrefObj.preferences!.containsKey(PrefKeys.CARNAME) ? true : false;
    print("adsadsa");
    print(PrefObj.preferences!.get(PrefKeys.CARID));
    print(userStr);
    getAddress();
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

  marker() async {
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(double.parse(lat), double.parse(long)),
        infoWindow: InfoWindow(title: 'The title of the marker')));
  }

  openWhatsapp() async {
    String whatsapp = '+97455929250';
    String whatsappURlAndroid =
        "whatsapp://send?phone=$whatsapp&text=Hi imechano, It's emergency";
    await launchUrl(Uri.parse(whatsappURlAndroid));
    String whatsappURLIos =
        "https://wa.me/$whatsapp?text=${Uri.parse("Hi imechano, Its emergency")}";
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(whatsappURLIos));
    } else {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    }
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

  void showSelectCarDialog() {
    showDialog(
      builder: (_) => AlertDialog(
        title: Text(getTranslated("Nocarselected!", context)),
        content: Text(getTranslated('Pleaseselectacartoproceed', context)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(_).pop(false),
            //return false when click on "NO"
            child: Text(getTranslated('close', context)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomBarPage(0),
                    //  SelectYourCarScreen(
                    //     type: AddCarType.home)
                  ));
            },
            //return true when click on "Yes"
            child: Text(getTranslated('Select', context)),
          ),
        ],
      ),
      context: context,
    );
  }

  Future<bool> callemergencyCarBookingAPI() async {
    try {
      bool isCarAdded = PrefObj.preferences!.containsKey(PrefKeys.CARID);
      if (isCarAdded) {
        final CarBookingModal? isCarBooked =
            await _repository.emergencycarbookingAPI(
                userStr,
                DateFormat('yyyy/MM/dd kk:mm').format(_selectedValue),
                address,
                PrefObj.preferences!.get(PrefKeys.CARID),
                workdoneController.text.toString(),
                imagefiles);
        if (isCarBooked != null) {
          log('Code: ${isCarBooked.code!}');
          if (isCarBooked.code != '0') {
            FocusScope.of(context).requestFocus(FocusNode());
            Fluttertoast.showToast(
                msg: isCarBooked.message ?? 'Booking done successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.lightBlueAccent,
                textColor: Colors.white,
                fontSize: 16.0);
            return true;
          } else {
            FocusScope.of(context).requestFocus(FocusNode());
            Fluttertoast.showToast(
                msg: isCarBooked.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.lightBlueAccent,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          snackBar('Something went wrong, please try again!', context);
        }
      }
    } catch (e) {
      snackBar('Something went wrong, please try again!', context);
      log(e.toString());
    }
    return false;
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

  void showSelectLocation() {
    showDialog(
        context: context,
        builder: (_) => Dialog(
              backgroundColor: Colors.white,
              child: _changeAddress(),
            ));
    setState(() {});
  }

  Widget _body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: appModelTheme.darkTheme ? Color(0xff252525) : white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _topImage(),
            // _textContainer(),
            // _dotBorder(),
            _dottedContainer(),
            SizedBox(height: 10),
            _containerTextfield(),
            SizedBox(
              //  ==============================by jenish======================
              height: 20,
            ),
            _appoinmentButton(),
            SizedBox(
              //  ==============================by jenish======================
              height: 10,
            ),
            _whatsappButton(),
            SizedBox(
              //  ==============================by jenish======================
              height: 10,
            ),
            _callButton()
          ],
        ),
      ),
    );
  }

  Widget _topImage() {
    return Container(
      child: Image.asset('assets/images/towtruck.jpg'),
    );
  }

  Widget _dottedContainer() {
    return DottedBorder(
        color: Color(0xff70BDF1),
        borderType: BorderType.RRect,
        radius: Radius.circular(12.sp),
        dashPattern: [5, 5],
        child: StatefulBuilder(
          builder: (context, setState1) => ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.sp)),
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
                      //       fontSize: 14.sp,
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
                                  getTranslated('uploadyourcarphoto', context),
                                  style: TextStyle(
                                    fontSize: 12,
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
                                            fontSize: 18.sp,
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
                                            fontSize: 18.sp,
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
                hintText: getTranslated('Problemyourcarhas', context)),
          ),
        ),
      ),
    );
  }

  Widget _textContainer() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        height: 105,
        width: 414.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffE6E6E5),
            width: 1, //                   <--- border width here
          ),
          color: appModelTheme.darkTheme ? darkmodeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Please enter whatever you are\n experincing in the car',
            style: TextStyle(fontSize: 15, fontFamily: 'Poppins3'),
          ),
        ),
      ),
    );
  }

  Widget _dotBorder() {
    // ================================by jenish=====================
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: DottedBorder(
        dashPattern: [6, 6],
        color: appModelTheme.darkTheme ? white : Color(0xffBFBFBF),
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
              // =================================by jenish =======================
              height: 92,
              width: 327.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10.w),
                  Column(
                    // =============================================by jenish==================
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 7),
                        child: Text(
                          'Upload Your Car Photo',
                          style: TextStyle(
                              fontSize: 13, fontFamily: 'Montserrat1'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // ==========================================by jenish=============================
                        height: 33,
                        width: 155,
                        child: Row(
                          children: [
                            SizedBox(width: 20.w),
                            Text(
                              'Picture Upload',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat1'),
                            ),
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.file_upload_outlined,
                              size: 22.sp,
                              color: buttonGrayE8E8E7Border,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: uploadbutton,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _appoinmentButton() {
    return Container(
      // =========================new============== by jenish====================
      height: 48,
      width: 327.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          primary: Color(0xff70BDF1), // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          if (!isCarAdded ||
              PrefObj.preferences!.get(PrefKeys.CARNAME).toString().length <
                  2) {
            log("car not added");
            showSelectCarDialog();
            Fluttertoast.showToast(
                msg: "Please Select A Car",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black12,
                textColor: Colors.black,
                fontSize: 16.0);
          } else if (address.contains('Select your address')) {
            showSelectLocation();
            Fluttertoast.showToast(
                msg: "Select your address first",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (imagefiles != null && workdoneController.text.isEmpty) {
            Fluttertoast.showToast(
                msg: 'Please enter the situation',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
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
        // ===========================by jenish =======================
        child: Text(
          getTranslated('Bookanappoinment', context),
          style: TextStyle(
              fontFamily: 'Poppins1', color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _changeAddress() {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Container(
        height: 150.h,
        width: MediaQuery.of(context).size.width.w,
        child: Column(
          children: [
            Text("Please Select your address first"),
            SizedBox(
              height: 10.h,
            ),
            Row(
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
                          size: 15.sp,
                          color: red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Change',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Okay")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _whatsappButton() {
    return Container(
      height: 48,
      width: 327.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          primary: Color.fromRGBO(37, 211, 102, 1), // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          openWhatsapp();
          var whatsappURl_android =
              "whatsapp://send?phone=923430529998&text=hello";
          var whatappURL_ios =
              "https://wa.me/923430529998?text=${Uri.parse("hello")}";
        },
        child: Text(
          getTranslated('WhatsappMessage', context),
          style: TextStyle(
              fontFamily: 'Poppins1', color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _callButton() {
    return Container(
      height: 48,
      width: 327.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          primary: Color(0xff70BDF1), // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          _makePhoneCall("+97455929250");
        },
        child: Text(
          getTranslated('callnow', context),
          style: TextStyle(
              fontFamily: 'Poppins1', color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Widget _DateTime() {
    return Card(
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
                  padding:
                      EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: 'Poppins3',
                        color: appModelTheme.darkTheme ? white : Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime currentTime = DateTime.now();
                  DateTime twoHoursLater =
                      currentTime.add(Duration(minutes: 30));
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
                        'Please select a booking time atleast 30 minutes later');
                  } else {
                    log('api hit');
                    Loader().showLoader(context);

                    bool response = await callemergencyCarBookingAPI();

                    Loader().hideLoader(context);
                    Navigator.pop(context);
                    if (response) {
                      currentBookingTab = 0;
                      Get.offAll(() => BottomBarPage(1));
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: logoBlue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding:
                      EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontFamily: 'Poppins3'),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          )
        ],
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
        //use24hFormat: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    hh = MediaQuery.of(context).size.height;
    ww = MediaQuery.of(context).size.width;
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
        appBar: WidgetAppBar(
          title: getTranslated('Emergency', context),
          menuItem: 'assets/svg/Menu.svg',
          imageicon: 'assets/svg/Arrow_alt_left.svg',
          action2: 'assets/svg/ball.svg',
        ),
        drawer: drawerpage(),
        backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
        body: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: () => SafeArea(
            child: Column(children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          appModelTheme.darkTheme ? Color(0xff252525) : white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0))),
                  child: _body(),
                ),
              ),
            ]),
          ),
        ));
  }
}
