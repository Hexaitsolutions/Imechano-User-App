// // ignore_for_file: deprecated_member_use
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:imechano/ui/provider/theme_provider.dart';
// import 'package:imechano/ui/screens/bottombar/ContactUs.dart';
// import 'package:imechano/ui/screens/bottombar/my%20invoice.dart';
// import 'package:imechano/ui/screens/bottombar/my_job_card.dart';
// import 'package:imechano/ui/screens/bottombar/mybooking.dart';
// import 'package:imechano/ui/screens/bottombar/profile.dart';
// import 'package:imechano/ui/screens/my_account/home.dart';
// import 'package:imechano/ui/screens/location/location_map.dart';
// import 'package:imechano/ui/screens/my_account/Notification.dart';
// import 'package:imechano/ui/screens/my_account/progress_report_inactive.dart';
// import 'package:imechano/ui/screens/select_car/view/privacy_policy.dart';
// import 'package:imechano/ui/share_preferences/preference.dart';
// import 'package:imechano/ui/styling/colors.dart';
// import 'package:provider/provider.dart';
//
// class MyAccount extends StatefulWidget {
//   const MyAccount({Key? key}) : super(key: key);
//   @override
//   _MyAccountState createState() => _MyAccountState();
// }
//
// class _MyAccountState extends State<MyAccount> {
//   bool isSwitch = false;
//   List titleMyAccount = [
//     "Home",
//     "My Profile",
//     "My Vehicle",
//     "My Booking",
//     "My Location",
//     "My Invoice",
//     "My Job Card",
//     "Notification",
//     "Privacy Policy"
//   ];
//   List imageMyAccount = [
//     "assets/icons/My Account/noun_Home_4334361.png",
//     "assets/icons/My Account/person_black_24dp.png",
//     "assets/icons/My Account/Path 8567.png",
//     "assets/icons/My Account/noun_calender_2189968.png",
//     "assets/icons/My Account/location.png",
//     "assets/icons/My Account/file-text.png",
//     "assets/icons/My Account/Desk_alt_fill.png",
//     "assets/icons/My Account/notifications_black_24dp.png",
//     "assets/icons/My Account/Chield_check_fill.png",
//   ];
//   List pageMyAccount = [
//     HomeScreen(),
//     ProfilePage(),
//     ProgressreportInactive(),
//     MyBooking(),
//     MapLocation(),
//     ContactUs(),
//     MyJobCard(),
//     NotificationScreen(),
//     ContactUs(),
//   ];
//
//   dynamic appModelTheme;
//
//   @override
//   Widget build(BuildContext context) {
//     final appModel = Provider.of<AppModel>(context);
//     appModelTheme = appModel;
//     return Scaffold(
//       backgroundColor: appModelTheme.darkTheme ? black : Color(0xff70bdf1),
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 5.h,
//             ),
//             appBar(),
//             SizedBox(
//               height: 10.h,
//             ),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: appModelTheme.darkTheme ? Color(0xff252525) : white,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(30.0),
//                     topLeft: Radius.circular(30.0),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 40.h,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.only(left: 30, right: 30),
//                         child: SvgPicture.asset(
//                           "assets/svg/imechano-logo.svg",
//                           color: appModelTheme.darkTheme ? white : null,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 40.h,
//                       ),
//                       listMenu(),
//                       switchButton(),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               alignment: Alignment.center,
//                               //height: 45.h,
//                               child: ListTile(
//                                 leading: Container(
//                                   margin: EdgeInsets.only(left: 5.w),
//                                   child: Image(
//                                       height: 23.h,
//                                       image: AssetImage(
//                                           "assets/icons/My Account/Sign_in.png")),
//                                 ),
//                                 title: GestureDetector(
//                                   onTap: () {
//                                     logOutDialog();
//                                   },
//                                   child: Text("Logout",
//                                       style: TextStyle(fontFamily: "Poppins3")),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // SizedBox(height: 70.h)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget appBar() {
//     return Row(
//       children: [
//         SizedBox(width: 10.w),
//         InkWell(
//           onTap: () {
//             // Get.off(BottomBar());
//           },
//           child: Container(
//             margin: EdgeInsets.all(10.h),
//             child: Icon(
//               Icons.arrow_back,
//               color: white,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.all(10.h),
//               child: Text(
//                 "My Account",
//                 style: TextStyle(
//                     color: white, fontSize: 20.sp, fontFamily: "Poppins1"),
//               )),
//         ),
//         Container(
//           margin: EdgeInsets.all(15.h),
//           child: Icon(
//             Icons.notifications,
//             color: white,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget listMenu() {
//     return ListView.separated(
//       separatorBuilder: (context, index) {
//         return Divider(
//           indent: 30,
//           endIndent: 30,
//         );
//       },
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: imageMyAccount.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//             onTap: () {
//               if (index == 0)
//                 Get.to(HomeScreen());
//               else if (index == 1) {
//                 Get.to(ProfilePage());
//               } else if (index == 2)
//                 Get.to(ProgressreportInactive());
//               else if (index == 3)
//                 Get.to(MyBooking());
//               else if (index == 4)
//                 Get.to(MapLocation());
//               else if (index == 5)
//                 Get.to(MyInvoice());
//               else if (index == 6)
//                 Get.to(MyJobCard());
//               else if (index == 7)
//                 Get.to(NotificationScreen());
//               else if (index == 8) Get.to(PrivacyPolicyScreen());
//             },
//             trailing: Icon(Icons.arrow_forward_ios),
//             leading: Container(
//               margin: EdgeInsets.only(left: 7.w),
//               child: Image(
//                   height: 20.h, image: AssetImage("${imageMyAccount[index]}")),
//             ),
//             title: Text("${titleMyAccount[index]}",
//                 style: TextStyle(fontFamily: "Poppins3")));
//       },
//     );
//   }
//
//   Widget switchButton() {
//     return Row(
//       children: [
//         Expanded(
//             child: Column(
//           children: [
//             SizedBox(
//               height: 10.h,
//             ),
//             Container(
//               height: 1.h,
//               child: Divider(
//                 indent: 30,
//                 endIndent: 30,
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               height: 70.h,
//               child: ListTile(
//                 trailing: Switch(
//                   value: appModelTheme.darkTheme,
//                   onChanged: (value) {
//                     setState(() {
//                       appModelTheme.darkTheme = !appModelTheme.darkTheme;
//
//                       //isSwitch = value;
//                       isSwitch
//                           ? ThemeData(
//                               brightness: Brightness.dark,
//                               /* light theme settings */
//                             )
//                           : ThemeData(
//                               brightness: Brightness.light,
//                               /* dark theme settings */
//                             );
//                       isSwitch = value;
//                     });
//                   },
//                 ),
//                 leading: Container(
//                   margin: EdgeInsets.only(left: 5.w),
//                   child: Image(
//                       height: 20.h,
//                       image:
//                           AssetImage("assets/icons/My Account/Path 131.png")),
//                 ),
//                 title: Text("Dark Theme",
//                     style: TextStyle(
//                         fontFamily: "Poppins3",
//                         color: appModelTheme.darkTheme ? white : black)),
//               ),
//             ),
//             Container(
//               height: 1.h,
//               child: Divider(
//                 indent: 30,
//                 endIndent: 30,
//               ),
//             ),
//           ],
//         ))
//       ],
//     );
//   }
//
//   void logOutDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Center(
//               child: Column(
//             children: [
//               Text(
//                 "Log out?",
//                 style: TextStyle(fontFamily: "Poppins2"),
//               ),
//               SizedBox(height: 15.h),
//               Text(
//                 "Are you sure you want to log out?",
//                 style: TextStyle(fontSize: 15.sp, fontFamily: "Poppins1"),
//               )
//             ],
//           )),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 FlatButton(
//                     textColor: Colors.black,
//                     child: Text(
//                       "Cancel",
//                       style: TextStyle(color: logoBlue, fontFamily: "Poppins1"),
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     }),
//                 FlatButton(
//                     child: Text('Log out',
//                         style: TextStyle(
//                             color: Colors.redAccent, fontFamily: "Poppins1")),
//                     onPressed: () {
//                       PrefObj.preferences?.clear();
//                       Navigator.of(context).pushNamedAndRemoveUntil(
//                           '/sign-in-sign-up-landing', (Route route) => false);
//                     })
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imechano/ui/modal/user_profile_modal.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/repository/repository.dart';
import 'package:imechano/ui/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:imechano/ui/screens/bottombar/car_check_Up_page.dart';
import 'package:imechano/ui/shared/widgets/form/custom_form.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:imechano/ui/styling/global.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  dynamic appModelTheme;
  TextEditingController name = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _repository = Repository();
  int _radioSelected = 1;
  var userid = "2";

  String? _radioVal = "male";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();

  XFile? image, temp;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;

    return appModelTheme.checkCon == true
        ? Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image(
                  image: AssetImage("assets/icons/splash/logo.png"),
                  height: 80.h,
                )),
                SizedBox(
                  height: 10.5,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: MaterialButton(
                    child: Text("Sign in"),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return SignInScreen();
                        },
                      ));
                    },
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            backgroundColor: appModelTheme.darkTheme ? black : logoBlue,
            body: Form(
              key: _formKey,
              child: ScreenUtilInit(
                designSize: Size(414, 896),
                builder: () => SafeArea(
                  child: Column(children: [
                    SizedBox(height: 10.h),
                    appBarWidget(),
                    SizedBox(height: 15.h),
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
                        child: _body(),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
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
              _editText(),
              SizedBox(height: 10.h),
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

  Widget appBarWidget() {
    return Row(
      children: [
        InkWell(
          // onTap: () {
          //   Navigator.pop(context);
          // },
          child: Container(
              margin: EdgeInsets.only(left: 17.sp),
              child: SvgPicture.asset("assets/svg/Menu.svg")),
        ),
        InkWell(
          // onTap: () {
          //   Navigator.pop(context);
          // },
          child: Container(
              margin: EdgeInsets.only(left: 24.sp),
              child: SvgPicture.asset("assets/svg/Arrow_alt_left.svg")),
        ),
        Expanded(
          child: Container(
              alignment: Alignment.center,
              child: Text(
                "My Profile",
                style: TextStyle(
                  color: white,
                  fontSize: 18.sp,
                  fontFamily: "Poppins1",
                ),
              )),
        ),
        Container(
            margin: EdgeInsets.only(right: 28.sp),
            child: SvgPicture.asset("assets/svg/shopping-cart.svg",
                height: 20.h, width: 20.w)),
        Container(
            margin: EdgeInsets.only(right: 25.sp),
            child: SvgPicture.asset("assets/svg/ball.svg",
                height: 20.h, width: 20.w)),
      ],
    );
  }

  Widget _profile() {
    return Stack(
      children: [
        temp != null
            ? Center(
                child: CircleAvatar(
                  radius: 55.h,
                  backgroundImage: FileImage(
                    File(temp!.path),
                  ),
                ),
              )
            : Center(
                child: CircleAvatar(
                  radius: 70.h,
                ),
              ),
        Positioned(
          top: 85.h,
          left: 154.w,
          child: GestureDetector(
              child: Container(
                height: 51.h,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(150.h),
                      bottomRight: Radius.circular(150.h),
                    )),
                width: 105.w,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text("SELECT ANY ONE"),
                      children: [
                        SimpleDialogOption(
                          child: InkWell(
                            onTap: () async {
                              image = await _picker.pickImage(
                                  source: ImageSource.camera);
                              setState(() {
                                temp = image;
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Camera",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        SimpleDialogOption(
                          child: InkWell(
                            onTap: () async {
                              image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                temp = image;
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Gallery",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
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

  Widget _editText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.edit,
          size: 13.sp,
          color: red.withOpacity(0.7),
        ),
        SizedBox(width: 5),
        Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 13.sp,
            color: red.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _username() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hi Rahul Sharma',
          style: TextStyle(fontSize: 17.sp, fontFamily: "Poppins1"),
        ),
        SizedBox(height: 10.h),
        Text(
          'Sign Out',
          style: TextStyle(fontSize: 15.sp, fontFamily: "Poppins1"),
        ),
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
          dateOfBirthForm(),
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
      controller: dateofbirth,
      imagePath: 'assets/icons/auth/sign_up/add-car.png',
      hintText: 'Date Of Birth',
    );
  }

  CustomForm mobileForm() {
    return CustomForm(
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
            'Gender',
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
        Text('Male'),
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
        Text('Female'),
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
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            Get.to(
              CarCheckupPage(),
            );
          }
        },
        child: Text(
          'Save',
          style: TextStyle(fontFamily: "Poppins2", color: white, fontSize: 18),
        ),
      ),
    );
  }

  dynamic onUpdateProfileAPI() async {
    // show loader
    Loader().showLoader(context);
    final UserProfileModel isUpdate = await _repository.onUserprofile(userid,
        name.text, email.text, dateofbirth.text, mobileno.text, _radioVal!);

    if (isUpdate.code == '1') {
      print("sucesss full");
      FocusScope.of(context).requestFocus(FocusNode());
      //   PrefObj.preferences!.put(PrefKeys.USER_DATA, json.encode(isLogin.data));
      Loader().hideLoader(context);
      showpopDialog(context, 'Sucessful Update',
          isUpdate.message != null ? isUpdate.message! : '');
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
}
