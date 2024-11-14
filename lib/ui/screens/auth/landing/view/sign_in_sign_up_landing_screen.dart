import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:imechano/ui/screens/bottombar/bottom_bar.dart';
import 'package:imechano/ui/screens/privacy_policy/terms_of_use.dart';
import 'package:imechano/ui/shared/widgets/buttons/custom_button.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

import '../../../language/view/language_choose_screen.dart';

class SignInSignUpLandingScreen extends StatefulWidget {
  const SignInSignUpLandingScreen({Key? key}) : super(key: key);

  @override
  State<SignInSignUpLandingScreen> createState() =>
      _SignInSignUpLandingScreenState();
}

class _SignInSignUpLandingScreenState extends State<SignInSignUpLandingScreen> {
  dynamic appModelTheme;

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LanguageChooseScreen()),
          );
          return false; // Prevents default back button behavior
        },
        child: Scaffold(
          backgroundColor: appModelTheme.darkTheme ? Color(0xff252525) : white,
          body: ScreenUtilInit(
            designSize: Size(414, 896),
            builder: () => SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Center(
                                  child: Image(
                                      image: AssetImage(
                                          'assets/icons/splash/logo.png'),
                                      color: appModelTheme.darkTheme
                                          ? white
                                          : null),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: Center(
                                    child: Text(
                                        getTranslated("welcomemsg", context)),
                                  ),
                                ),
                                Center(
                                  child: Image(
                                      height: 350,
                                      image: AssetImage(
                                          'assets/icons/splash/abc.png'),
                                      color: appModelTheme.darkTheme
                                          ? white
                                          : null),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            buttonsSection(),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            CustomButton(
                              title: Text(
                                getTranslated("guest", context),
                                style: TextStyle(
                                    fontSize: 16.sp, fontFamily: 'Poppins1'),
                              ),
                              width: 0.8,
                              callBackFunction: () {
                                // setState(() {
                                //   appModelTheme.checkCon = true;
                                // });
                                //bool checkConditionDrawer = true;
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return BottomBarPage(2);
                                  },
                                ));
                              },
                              bgColor: logoBlue,
                              borderColor: logoBlue,
                            ),
                            SizedBox(height: 40.h),
                            TermsOfUse(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Row buttonsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          title: Text(
            getTranslated('signin', context),
            style: TextStyle(fontSize: 16.sp, fontFamily: 'Poppins1'),
          ),
          width: 0.35,
          callBackFunction: () {
            setState(() {
              appModelTheme.checkCon = false;
            });
            // bool checkCondition = false;
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SignInScreen();
              },
            ));
          },
          bgColor: buttonNaviBlue162e3f,
          borderColor: buttonNaviBlue162e3f,
        ),
        orDividerSection(),
        CustomButton(
          title: Text(
            getTranslated('Signup', context),
            style: TextStyle(fontSize: 16.sp, fontFamily: 'Poppins1'),
          ),
          width: 0.35,
          callBackFunction: () {
            setState(() {
              appModelTheme.checkCon = false;
            });
            Get.toNamed('/sign-up');
          },
          bgColor: buttonBlue3b5999,
          borderColor: buttonBlue3b5999,
        ),
      ],
    );
  }

  Padding orDividerSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 9, right: 9),
      child: Column(
        children: [
          Container(
            height: 15.h,
            child: VerticalDivider(
              width: 10,
              color: appModelTheme.darkTheme ? white : Color(0xff374049),
              thickness: 1.5,
            ),
          ),
          Text(
            getTranslated("OR", context),
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: 'Poppins1',
              color: appModelTheme.darkTheme ? white : Color(0xff374049),
            ),
          ),
          Container(
            height: 15.h,
            child: VerticalDivider(
              width: 10,
              color: appModelTheme.darkTheme ? white : Color(0xff374049),
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
