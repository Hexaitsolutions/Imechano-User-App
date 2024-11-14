// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/modal/user_profile_modal.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_drawer_widget.dart';
import 'package:imechano/ui/shared/widgets/buttons/custom_button.dart';
import 'package:imechano/ui/shared/widgets/form/custom_form.dart';
import 'package:imechano/ui/shared/widgets/form/custom_form_mobile.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';

import 'package:provider/provider.dart';


import '../../shared/widgets/form/custom_form_car.dart';
import '../../styling/config.dart';
import 'bottom_bar.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

late String profilename;
late String userphoneno;
late String profileurl;

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController name = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController carname = TextEditingController();
  // TextEditingController dateofbirth = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _repository = Repository();
  int _radioSelected = 1;
  var userid = "2";

  String? _radioVal = "male";

  bool isLoading = false;
  var userStr;
  var profileData;
  var profileFile;
  @override
  void initState() {
    super.initState();

    userStr =
        PrefObj.preferences!.containsKey(PrefKeys.USER_DATA) ? true : false;

    if (userStr) {
      profileData =
          json.decode(PrefObj.preferences!.get(PrefKeys.PROFILE_DATA));
      print(profileData);
      name.text = profileData['name'].toString();
      mobileno.text = profileData['mobile_number'].toString();
      print(profileData['profile'].toString());
      if (!profileData['profile'].toString().contains("null")) {
        profileurl = Config.profileurl + profileData['profile'].toString();
        PrefObj.preferences!.put(PrefKeys.PROFILE_IMG, profileurl);
      }
      // profileFile = _fileFromImageUrl(profileurl);
      email.text = profileData['email'].toString();
      carname.text = "Select Car";
      if (PrefObj.preferences!.containsKey(PrefKeys.CARNAME)) {
        carname.text = PrefObj.preferences!.get(PrefKeys.CARNAME).toString();
      } else {
        carname.text = "Select Car";
      }
      // dateofbirth.text = profileData['dob'].toString().contains('null')
      //     ? ''
      //     : profileData['dob'];
      _radioVal = profileData["gender"] ?? "male";
    }
    profilename = name.text;
    userphoneno = mobileno.text;
  }

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  XFile? image, temp;
  bool status = false;

  dynamic appModelTheme;

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;

    return WillPopScope(
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
          appBar: WidgetAppBar(
            title: getTranslated('myprofile', context),
            menuItem: 'assets/svg/Menu.svg',
            action: 'assets/svg/shopping-cart.svg',
            action2: 'assets/svg/ball.svg',
          ),
          key: _key,
          drawer: drawerpage(),
          backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
          body: Form(
            key: _formKey,
            child: ScreenUtilInit(
              designSize: Size(414, 896),
              builder: () => SafeArea(
                child: Column(children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          color: appModelTheme.darkTheme
                              ? Color(0xff252525)
                              : white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25.0),
                              topLeft: Radius.circular(25.0))),
                      child: userStr ? _body() : _body2(),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }

  Widget _body() {
    return Container(
      decoration: BoxDecoration(
        color: appModelTheme.darkTheme ? Color(0xff252525) : Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              _profile(),
              SizedBox(height: 15.h),
              _username(),
              SizedBox(height: 10.h),
              SingleChildScrollView(
                child: _scrollBarWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _body2() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/imechano-logo.svg",
            height: MediaQuery.of(context).size.height * 0.11,
            color: appModelTheme.darkTheme ? white : null,
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: MaterialButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SignInScreen();
                  },
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _profile() {
    return Stack(
      children: [
        PrefObj.preferences!.containsKey(PrefKeys.PROFILE_IMG)
            ? Center(
                child: CircleAvatar(
                  radius: 55.h,
                  backgroundImage: NetworkImage(
                      PrefObj.preferences!.get(PrefKeys.PROFILE_IMG)),
                ),
              )
            : Center(
                child: CircleAvatar(
                  radius: 55.h,
                  child: Icon(Icons.person, size: 50.sp),
                ),
              ),
        Positioned(
          top: 0.h,
          left: 162.2.w,
          child: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 55.h,
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
                                  image = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  onUploadAPI(
                                      PrefObj.preferences!
                                          .get(PrefKeys.USER_ID),
                                      File(image!.path));
                                  setState(() {
                                    temp = image;
                                  });
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
                                  image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  onUploadAPI(
                                      PrefObj.preferences!
                                          .get(PrefKeys.USER_ID),
                                      File(image!.path));
                                  setState(() {
                                    temp = image;
                                  });
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
        )
      ],
    );
  }

  Widget _username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${getTranslated('Hi', context)} ' + '${name.text.toUpperCase()}',
          style: TextStyle(fontSize: 17.sp, fontFamily: "Poppins1"),
        ),
        SizedBox(height: 10.h),
        CustomButton(
            title: Text(getTranslated('Signout', context)),
            width: 0.3,
            callBackFunction: () => logOutDialog(),
            bgColor: red,
            borderColor: red),
      ],
    );
  }

  Widget _scrollBarWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          nameForm(),
          SizedBox(height: 15.h),
          emailForm(),
          SizedBox(height: 15.h),
          carForm(),
          // dateOfBirthForm(),
          SizedBox(height: 15.h),
          mobileForm(),
          SizedBox(height: 15.h),
          gender(),
          redio(),
          _save(),
        ],
      ),
    );
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
      hintText: 'Name',
    );
  }

  CustomForm emailForm() {
    return CustomForm(
      fillColor: appModelTheme.darkTheme ? darkmodeColor : grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Fil The Email';
        }
        return null;
      },
      controller: email,
      imagePath: 'assets/icons/auth/sign_up/email.png',
      hintText: 'Email',
    );
  }

  CustomForm dateOfBirthForm() {
    return CustomForm(
      fillColor: appModelTheme.darkTheme ? darkmodeColor : grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Fil The Date of Birth';
        }
        return null;
      },
      controller: carname,
      imagePath: 'assets/icons/auth/sign_up/add-car.png',
      hintText: 'Select Car',
    );
  }

  CustomFormCar carForm() {
    return CustomFormCar(
      fillColor: appModelTheme.darkTheme ? darkmodeColor : grayE6E6E5,
      validationform: (value) {
        // if (value == null || value.isEmpty) {
        //   return 'Please enter Fil The Date of Birth';
        // }
        return null;
      },
      readOnly: true,
      controller: carname,
      imagePath: 'assets/icons/auth/sign_up/add-car.png',
      hintText: 'Select Car',
      customOnTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarPage(0),
            ));
      },
    );
  }

  CustomFormMobile mobileForm() {
    return CustomFormMobile(
      fillColor: appModelTheme.darkTheme ? darkmodeColor : grayE6E6E5,
      validationform: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Fil The Mobile No';
        }
        return null;
      },
      controller: mobileno,
      imagePath: 'assets/icons/auth/sign_up/mobile-number.png',
      hintText: 'Mobile No',
    );
  }

  Widget gender() {
    return Row(
      children: [
        SizedBox(width: 5.w),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            getTranslated('Gender', context),
            style: TextStyle(fontSize: 20.sp, fontFamily: "Poppins1"),
          ),
        ]),
      ],
    );
  }

  Widget redio() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: 1,
          groupValue: _radioSelected,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _radioSelected = value as int;
              //print('value1 = $value');

              _radioVal = 'male';
            });
          },
        ),
        Text(getTranslated('Male', context)),
        Radio(
          value: 2,
          groupValue: _radioSelected,
          activeColor: Colors.pink,
          onChanged: (value) {
            setState(() {
              _radioSelected = value as int;
              print('value2 = $value');
              _radioVal = 'female';
            });
          },
        ),
        Text(getTranslated('Female', context)),
      ],
    );
  }

  Widget _save() {
    return Container(
      height: 58.h,
      width: 370.w,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (_formKey.currentState!.validate()) {
            onUpdateProfileAPI();
          }
        },
        child: Text(
          getTranslated('Save', context),
          style: TextStyle(fontFamily: "Poppins2", color: white, fontSize: 18),
        ),
      ),
    );
  }

  dynamic onUpdateProfileAPI() async {
    // show loader
    Loader().showLoader(context);
    final UserProfileModel isUpdate = await _repository.onUserprofile(
        PrefObj.preferences!.get(PrefKeys.USER_ID),
        name.text,
        email.text,
        mobileno.text,
        carname.text,
        _radioVal!);

    if (isUpdate.code == '1') {
      print("sucesss full");

      //   PrefObj.preferences!.put(PrefKeys.USER_DATA, json.encode(isLogin.data));
      Loader().hideLoader(context);
      PrefObj.preferences!
          .put(PrefKeys.PROFILE_DATA, json.encode(isUpdate.data));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isUpdate.message ?? '')),
      );

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => BottomBarPage(),
      //   ),
      // );
    } else {
      print("Fails");
      Loader().hideLoader(context);
      showpopDialog(
          context, 'Error', isUpdate.message != null ? isUpdate.message! : '');
    }
  }

  void showpopDialog(BuildContext context, String title, String body) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void logOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Column(
            children: [
              Text(
                "Log out?",
                style: TextStyle(fontFamily: "Poppins2"),
              ),
              SizedBox(height: 15.h),
              Text(
                "Are you sure you want to log out?",
                style: TextStyle(fontSize: 15.sp, fontFamily: "Poppins1"),
              )
            ],
          )),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    // textColor: Colors.black,
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: logoBlue, fontFamily: "Poppins1"),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    child: Text('Log out',
                        style: TextStyle(
                            color: Colors.redAccent, fontFamily: "Poppins1")),
                    onPressed: () {
                      PrefObj.preferences?.clear();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/sign-in-sign-up-landing', (Route route) => false);
                    })
              ],
            ),
          ],
        );
      },
    );
  }

  dynamic onUploadAPI(String userId, File image) async {
    // show loader
    Loader().showLoader(context);
    final isUploaded;
    try {
      isUploaded = await _repository.onUpload(userId, image);
      if (!isUploaded.toString().contains("null")) {
        PrefObj.preferences!
            .put(PrefKeys.PROFILE_IMG, Config.profileurl + isUploaded);
        print(isUploaded);
        profileurl = Config.profileurl + isUploaded.toString();
        Loader().hideLoader(context);
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error on Uploading");
      Loader().hideLoader(context);
      Navigator.pop(context);
    }
  }

  // Future<File> _fileFromImageUrl(Uri imgURL) async {
  //   final response = await http.get(imgURL);
  //
  //   final documentDirectory = await getApplicationDocumentsDirectory();
  //
  //   final file = File(p.join(documentDirectory.path, 'imagetest.png'));
  //
  //   file.writeAsBytesSync(response.bodyBytes);
  //
  //   return file;
  // }
}
