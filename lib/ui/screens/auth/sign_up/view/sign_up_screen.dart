// ignore_for_file: non_constant_identifier_names, unused_field, deprecated_member_use

import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/modal/addcar_modelClass.dart';
import 'package:imechano/ui/modal/register_model.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/location/location_map.dart';
import 'package:imechano/ui/screens/privacy_policy/policy_dailogue.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/buttons/custom_button.dart';
import 'package:imechano/ui/shared/widgets/form/custom_form.dart';
import 'package:imechano/ui/shared/widgets/text_widgets.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../shared/widgets/form/custom_form_mobile.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _repository = Repository();
  final _formKey2 = GlobalKey<FormState>();
  bool agreePolicy = false;
  bool showPassword = true;
  String addressBtn = getTranslated("Savemylocation", Get.context!);
  bool addressIsChanged = true;
  TextEditingController creatpassword = TextEditingController();
  TextEditingController Confirmpassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController otpcode = TextEditingController();
  TextEditingController resetpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String fcmToken = '';
  String latitude = '';
  String longitude = '';
  String address = '';
  String otpCode = '1234';
  String id = '';
  final _formKey = GlobalKey<FormState>();
  var carid;
  dynamic appModelTheme;
  late CountdownTimerController timerController;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void firebaseCloudMessaging_Listeners() async {
    // if (Platform.isIOS) iOS_Permission();

    await _firebaseMessaging.getToken().then((token) {
      print(token);
      fcmToken = token!;
    });
  }

  @override
  void initState() {
    firebaseCloudMessaging_Listeners();
    // TODO: implement initState
    super.initState();
    carid = PrefObj.preferences!.containsKey(PrefKeys.CARID) ? true : false;
    timerController = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Scaffold(
        body: ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return true;
        },
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    SvgPicture.asset(
                      "assets/svg/imechano-logo.svg",
                      width: 200,
                    ),
                    SizedBox(height: 10),
                    Text(getTranslated('createanaccount', context),
                        style: TextStyle(
                            fontFamily: "Poppins3",
                            fontSize: 20,
                            color: Colors.black)),
                    SizedBox(height: 10),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          emailForm(),
                          SizedBox(height: 20),
                          mobileForm(),
                          SizedBox(height: 20),
                          nameForm(),
                          SizedBox(height: 20),
                          _textfiled(creatpassword,
                              getTranslated('Createpassword', context)),
                          SizedBox(height: 20),
                          _confirmPassfiled(Confirmpassword,
                              getTranslated('confirmPassword', context)),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 66,
                            child: CustomButton(
                              title: Row(
                                children: [
                                  Image.asset("assets/images/Location.png",
                                      scale: 4),
                                  SizedBox(width: 10),
                                  Regular16Black(
                                    addressBtn,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              width: 0.9,
                              callBackFunction: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapLocation()),
                                );
                                latitude = result.toString().split('/')[0];
                                longitude = result.toString().split('/')[1];
                                address = result.split('/')[2];
                                var addressTxt = "";
                                if (address.length > 30)
                                  for (int i = 0; i < 28; i++) {
                                    addressTxt += address[i];
                                  }
                                addressTxt += ".....";
                                print(result);
                                addressIsChanged = !addressIsChanged;
                                setState(() {
                                  addressIsChanged == true
                                      ? addressBtn = "Save My Location"
                                      : addressBtn = addressTxt;
                                });
                              },
                              bgColor: grayE6E6E5,
                              borderColor: buttonGrayE8E8E7Border,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 66,
                            child: CustomButton(
                              title: Row(
                                children: [
                                  Image.asset("assets/images/car.png",
                                      scale: 4),
                                  SizedBox(width: 10.w),
                                  Regular16Black(
                                    getTranslated(
                                        'Addmycar(optional)', context),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              width: 0.9,
                              callBackFunction: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                Get.toNamed('/select-your-car');
                              },
                              bgColor: grayE6E6E5,
                              borderColor: buttonGrayE8E8E7Border,
                            ),
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            height: 58,
                            child: CustomButton(
                              title: Text(
                                getTranslated('Signup', context),
                                style: TextStyle(
                                    fontSize: 18.sp, fontFamily: "poppins1"),
                              ),
                              width: 0.9,
                              callBackFunction: () {
                                if (!agreePolicy) {
  Get.snackbar(
    getTranslated('tocmessage', context),
    "",
    backgroundColor: Colors.red,
    colorText: Colors.white
  );
  return; // Stop execution here so it doesn't call onRegisterAPI()
}
                                if (_formKey.currentState!.validate()) {
                                  validatePassword(creatpassword.text);
                                  validateConfirmPassword(Confirmpassword.text);
                                  onRegisterAPI();
                                  // showOtpModelsheet();
                                }
                              },
                              bgColor: logoBlue,
                              borderColor: logoBlue,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  getTranslated("alreadyhaveaccount", context) +
                                      " ?",
                                  style: TextStyle(
                                      fontFamily: 'poppins1',
                                      fontSize: 15.sp,
                                      color: appModelTheme.darkTheme
                                          ? white
                                          : black)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(getTranslated('signin', context),
                                      style: TextStyle(
                                          fontFamily: 'poppins1',
                                          fontSize: 15.sp,
                                          color: appModelTheme.darkTheme
                                              ? logoBlue
                                              : red))),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:
                                        "${getTranslated("term_condition_message", context)} \n ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    children: [
                                      TextSpan(
                                        text: getTranslated(
                                            "terms_and_condition", context),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: buttonBlue3b5999),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showModal(
                                              context: context,
                                              configuration:
                                                  FadeScaleTransitionConfiguration(),
                                              builder: (context) {
                                                return PolicyDialog(
                                                  mdFileName: 'toc.md',
                                                );
                                              },
                                            );
                                          },
                                      ),
                                      TextSpan(
                                          text:
                                              "${getTranslated("and", context)} "),
                                      TextSpan(
                                        text:
                                            "${getTranslated("privacy_policy", context)}!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: buttonBlue3b5999),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return PolicyDialog(
                                                  mdFileName: 'privacy.md',
                                                );
                                              },
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                  value: agreePolicy,
                                  onChanged: (value) {
                                    setState(() {
                                      agreePolicy = value!;
                                    });
                                  },
                                ), //
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _textfiled(TextEditingController controller, String title) {
    return Container(
      child: TextFormField(
        style: TextStyle(fontFamily: "Poppins3"),
        validator: validatePassword,
        controller: controller,
        obscureText: showPassword,
        decoration: InputDecoration(
          fillColor: grayE6E6E5,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          prefixIcon:
              Image.asset('assets/icons/auth/sign_up/create-password.png'),
          hintText: title,
          hintStyle: TextStyle(fontFamily: "Poppins3", color: black),
          prefixIconConstraints: BoxConstraints(minWidth: 40),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _confirmPassfiled(TextEditingController controller, String title) {
    return Container(
      child: TextFormField(
        style: TextStyle(fontFamily: "Poppins3"),
        validator: validateConfirmPassword,
        controller: controller,
        obscureText: showPassword,
        decoration: InputDecoration(
          fillColor: grayE6E6E5,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          prefixIcon:
              Image.asset('assets/icons/auth/sign_up/create-password.png'),
          hintText: title,
          hintStyle: TextStyle(fontFamily: "Poppins3", color: black),
          prefixIconConstraints: BoxConstraints(minWidth: 40),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey),
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    print(value);
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    print(value);
    if (value == null || value.isEmpty) {
      return 'Please enter confirm password';
    }
    if (creatpassword.text != value) {
      return 'Confirm Password Not Match';
    }
    return null;
  }

  String? validatePassword1(String? pass, String? confirmpass) {
    print(confirmpass);
    if (confirmpass == null || confirmpass.isEmpty) {
      return 'Please enter Confirm password';
    }
    if (confirmpass != pass) {
      return 'Not Match';
    }
    return null;
  }

  CustomForm nameForm() {
    return CustomForm(
      fillColor: appModelTheme.darkTheme ? darkmodeColor : grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Fil The Name';
        }
        return null;
      },
      controller: name,
      imagePath: 'assets/icons/auth/sign_up/name.png',
      hintText: getTranslated('Name', context),
    );
  }

  CustomFormMobile mobileForm() {
    mobileno.addListener(() {
      if (mobileno.text.length > 8) {
        mobileno.text = mobileno.text.substring(0, 8);
        mobileno.selection = TextSelection.fromPosition(
          TextPosition(offset: mobileno.text.length),
        );
      }
    });
    return CustomFormMobile(
      fillColor: appModelTheme.darkTheme ? darkmodeColor : grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty || value.length < 8) {
          return getTranslated("PleaseenterFilTheMobileNo", context);
        }
        return null;
      },
      controller: mobileno,
      imagePath: 'assets/icons/auth/sign_up/mobile-number.png',
      hintText: getTranslated('MobileNo', context),
    );
  }

  CustomForm emailForm() {
    return CustomForm(
      fillColor: appModelTheme.darkTheme ? darkmodeColor : grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return getTranslated('PleaseenterFilTheEmailId', context);
        }
        return null;
      },
      controller: email,
      imagePath: 'assets/icons/auth/sign_up/email.png',
      hintText: getTranslated('Email', context),
    );
  }

  dynamic onotpAPI() async {
    // show loader
    Loader().showLoader(context);
    final RegisterModel isotp =
        await _repository.onotpAPI(email.text, otpCode, "2");

    if (isotp.code != '0') {
      FocusScope.of(context).requestFocus(FocusNode());
      PrefObj.preferences!.put(PrefKeys.USER_DATA, json.encode(isotp.data));
      PrefObj.preferences!.put(PrefKeys.PROFILE_DATA, json.encode(isotp.data));
      PrefObj.preferences!.put(PrefKeys.USER_ID, isotp.data!.id);
      PrefObj.preferences!.put(PrefKeys.CARID, isotp.data!.id);
      Loader().hideLoader(context);
      id = isotp.data!.id.toString();
      carid
          ? addCarApiCall()
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomBarPage(2),
              ));
      snackBar(getTranslated('RegisterSuccess', context));
      Fluttertoast.showToast(
          msg: isotp.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isotp.message != null ? isotp.message! : '');
    }
  }

  // dynamic onresetAPI() async {
  //   // show loader
  //   Loader().showLoader(context);
  //   final ResetPasswordModel isreset = await _repository.onreset(
  //       email.text, mobileno.text, resetpassword.text);

  //   if (isreset.code != '0') {
  //     FocusScope.of(context).requestFocus(FocusNode());
  //     PrefObj.preferences!.put(PrefKeys.USER_DATA, json.encode(isreset.data));

  //     id = isreset.data!.id.toString();
  //     addCarApiCall();
  //     //snackBar('forget Success!!');

  //   } else {
  //     Loader().hideLoader(context);
  //     showpopDialog(
  //         context, 'Error', isreset.message != null ? isreset.message! : '');
  //   }
  // }

  addCarApiCall() async {
    if (PrefObj.preferences!.containsKey(PrefKeys.ADDCARDATA)) {
      final carData =
          json.decode(PrefObj.preferences!.get(PrefKeys.ADDCARDATA));

      print(id);
      final addCarModel isAddcar = await _repository.onaddcarApi(
          '',
          id,
          carData['model'],
          carData['cylinder'],
          carData['mileage'],
          carData['model_year'],
          carData['plate_number'],
          carData['chases_number'],
          carData['fuelType'],
          carData['branId'],
          AddCarType.add);

      if (isAddcar.code == '1') {
        print("status Sucessful");
        PrefObj.preferences!
            .put(PrefKeys.USER_DATA, json.encode(isAddcar.data));
        Loader().hideLoader(context);

        snackBar('Register Success!!');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarPage(2),
            ));
        PrefObj.preferences!.delete(PrefKeys.ADDCARDATA);
        PrefObj.preferences!.put(PrefKeys.CARID, isAddcar.data!.id);
        PrefObj.preferences!.put(PrefKeys.CARNAME, isAddcar.data!.model);
      } else {
        print("Status Failed");

        showpopDialog(context, 'Error',
            isAddcar.message != null ? isAddcar.message! : '');
      }
    }
  }

  dynamic onRegisterAPI([String resendOTP = "no"]) async {
    // show loader
    Loader().showLoader(context);
    print("email.txt");
    print(email.text);
    print(mobileno.text);
    print(name.text);
    print(latitude);
    print(longitude);
    print(creatpassword.text);
    print(fcmToken);
    print(resendOTP);
    final RegisterModel isRegister = await _repository.onRegistration(
        email.text,
        mobileno.text,
        name.text,
        latitude,
        longitude,
        creatpassword.text,
        fcmToken,
        resendOTP);
    print(isRegister);
    if (isRegister.code != '0') {
      Loader().hideLoader(context);
      Fluttertoast.showToast(
          msg: isRegister.message.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      FocusScope.of(context).requestFocus(FocusNode());
      showOtpModelsheet();
    } else {
      Loader().hideLoader(context);
      showpopDialog(context, 'Error',
          isRegister.message != null ? isRegister.message! : '');
    }
  }

  // snackBar Widget
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showOtpModelsheet() {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      context: context,
      builder: (context) => Form(
        key: _formKey2,
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text("Enter 4 Digits Code",
                      style: TextStyle(
                          fontFamily: "Poppins3",
                          
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: logoBlue)),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                          "Enter 4 digits code that you received\non your mail",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Poppins1",
                            fontSize: 14,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      OtpTextField(
                        numberOfFields: 4,
                        borderColor: Color(0xFF512DA8),
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          //handle validation or checks here
                        },
                        autoFocus: false,

                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) {
                          if (_formKey2.currentState!.validate()) {
                            otpCode = verificationCode;
                            setState(() {});
                            onotpAPI();
                          }
                        }, // end onSubmit
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      // CustomButton(
                      //   title: Text(
                      //     'Continue',
                      //     style:
                      //         TextStyle(fontSize: 18, fontFamily: 'Poppins1'),
                      //   ),
                      //   width: 0.9,
                      //   bgColor: logoBlue,
                      //   borderColor: logoBlue,
                      //   callBackFunction: () {
                      //     if (_formKey2.currentState!.validate()) {
                      //       onotpAPI();
                      //     }
                      //   },
                      // ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "I don't receive code.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Poppins1",
                                height: 1.8,
                                fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              timerController.disposeTimer();
                              Navigator.pop(context);
                              onRegisterAPI("yes");
                            },
                            child: Text(
                              "Resend Code",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins1",
                                  color: Colors.red,
                                  height: 1.8,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      CountdownTimer(
                        endTime:
                            DateTime.now().millisecondsSinceEpoch + 1000 * 120,
                        widgetBuilder:
                            (BuildContext context, CurrentRemainingTime? time) {
                          if (time == null) {
                            return Text('OTP Expired!');
                          }
                          if (time.min != null && time.sec! < 10) {
                            return Text('01:0${time.sec} sec left');
                          }
                          if (time.min == null && time.sec! > 9) {
                            return Text('00:${time.sec} sec left');
                          }
                          if (time.min == null && time.sec! < 10) {
                            return Text('00:0${time.sec} sec left');
                          }
                          return Text('0${time.min}:${time.sec} sec left');
                        },
                        textStyle: TextStyle(
                            fontFamily: "Poppins1", height: 1.6, fontSize: 14),
                      ),
                      // SizedBox(
                      //   height: 23.h,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future _showmodelbottom1() {
  //   return showMaterialModalBottomSheet(
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(40), topRight: Radius.circular(40))),
  //     context: context,
  //     builder: (context) => Form(
  //       key: _formKey3,
  //       child: Container(
  //         margin: EdgeInsets.only(left: 25, right: 25),
  //         height: MediaQuery.of(context).size.height * 0.6,
  //         child: SingleChildScrollView(
  //           physics: BouncingScrollPhysics(),
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.02,
  //               ),
  //               Text("Reset Password",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 22,
  //                       color: logoBlue)),
  //               SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.02,
  //               ),
  //               Column(
  //                 children: [
  //                   Text(
  //                     "Set the new password for your account \n so you can login and access \n all the features",
  //                     style: TextStyle(fontFamily: "Poppins3", fontSize: 12),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   SizedBox(
  //                     height: MediaQuery.of(context).size.height * 0.03,
  //                   ),
  //                   CustomForm(
  //                     fillColor: appModelTheme.darkTheme
  //                         ? darkmodeColor
  //                         : grayE6E6E5,
  //                     validationform: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return 'Please enter Fil The Password';
  //                       }
  //                       return null;
  //                     },
  //                     controller: resetpassword,
  //                     imagePath:
  //                         'assets/icons/auth/sign_up/create-password.png',
  //                     hintText: 'Password',
  //                     isSuffix: true,
  //                     icon: Icons.visibility,
  //                   ),
  //                   SizedBox(height: MediaQuery.of(context).size.height * 0.03),
  //                   CustomForm(
  //                     fillColor: appModelTheme.darkTheme
  //                         ? darkmodeColor
  //                         : grayE6E6E5,
  //                     validationform: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return 'Please enter Fil The Confirm Password';
  //                       }
  //                       return null;
  //                     },
  //                     controller: confirmpassword,
  //                     ObscureText: true,
  //                     imagePath:
  //                         'assets/icons/auth/sign_up/create-password.png',
  //                     hintText: 'Confirm Password',
  //                     isSuffix: true,
  //                     icon: Icons.visibility_off,
  //                   ),
  //                   SizedBox(
  //                     height: 45.h,
  //                   ),
  //                   CustomButton(
  //                     title: Regular20White('Reset Password'),
  //                     width: 0.9,
  //                     bgColor: logoBlue,
  //                     borderColor: logoBlue,
  //                     callBackFunction: () {
  //                       if (_formKey3.currentState!.validate()) {
  //                         onresetAPI();
  //                       }
  //                     },
  //                   ),
  //                   SizedBox(
  //                     height: 30.h,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
