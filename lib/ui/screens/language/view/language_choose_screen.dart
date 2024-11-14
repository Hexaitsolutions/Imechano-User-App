import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/shared/widgets/buttons/custom_button.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

class LanguageChooseScreen extends StatefulWidget {
  const LanguageChooseScreen({Key? key}) : super(key: key);

  @override
  State<LanguageChooseScreen> createState() => _LanguageChooseScreenState();
}

class _LanguageChooseScreenState extends State<LanguageChooseScreen> {
  // bool myvalue = false;
  dynamic appModelTheme;

  Locale selectedLocale = Locale('en');

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(getTranslated('exitapp', context)),
            content: Text(getTranslated('doyouwanttoexitanapp', context)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(getTranslated('no', context)),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); // Exits the app on Yes press
                },
                child: Text(getTranslated('yes', context)),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => Scaffold(
          backgroundColor: appModelTheme.darkTheme ? Color(0xff252525) : white,
          body: Container(
            // height: size.height * 0.9,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 140.h),
                Container(
                  height: size.height * 0.1,
                  child: Column(
                    children: [
                      Text(
                        getTranslated('ChooseYour', context),
                        style: TextStyle(
                          fontFamily: "Poppins5",
                          fontSize: 26.sp,
                        ),
                      ),
                      Text(
                        getTranslated('Preferred', context),
                        style: TextStyle(
                          fontFamily: "Poppins5",
                          fontSize: 26.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 58.h,
                  child: CustomButton(
                    title: Text(
                      'English',
                      style: TextStyle(
                        fontFamily: "Montserrat2",
                        fontSize: 16.sp,
                      ),
                    ),
                    width: 0.8,
                    bgColor: appModel.appLocal == Locale('en')
                        ? logoBlue
                        : grayE6E6E5,
                    borderColor: transparent,
                    callBackFunction: () {
                      setState(() {
                        selectedLocale = Locale('en');
                        appModel.changeLanguage(selectedLocale);
                        //myvalue = false;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 58.h,
                  child: CustomButton(
                    title: Text(
                      'عربي',
                      style: TextStyle(
                        fontFamily: "Montserrat2",
                        fontSize: 20.sp,
                      ),
                    ),
                    width: 0.8,
                    bgColor: appModel.appLocal == Locale('ar')
                        ? logoBlue
                        : grayE6E6E5,
                    borderColor: transparent,
                    callBackFunction: () {
                      setState(() {
                        //myvalue = true;
                        selectedLocale = Locale('ar');
                        appModel.changeLanguage(selectedLocale);
                      });
                    },
                  ),
                ),
                SizedBox(height: 213.h),
                Container(
                  height: size.height * 0.1,
                  child: Column(
                    children: [
                      Text(
                        getTranslated('langmsg', context),
                        style:
                            TextStyle(fontFamily: "Poppins3", fontSize: 15.sp),
                      ),
                      Text(
                        getTranslated('langmsg2', context),
                        style:
                            TextStyle(fontFamily: "Poppins3", fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 60.h,
                  child: CustomButton(
                    title: Text(
                      getTranslated("Continue", context),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Poppins1',
                      ),
                    ),
                    width: 0.8,
                    bgColor: appModelTheme.darkTheme ? darkmodeColor : logoBlue,
                    borderColor: appModelTheme.darkTheme
                        ? darkmodeColor
                        : buttonBlueBorder,
                    callBackFunction: () {
                      appModel.changeLanguage(selectedLocale);
                      PrefObj.preferences!.put(PrefKeys.APPSTARTED, true);
                      Get.offNamed('/on-boarding');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
