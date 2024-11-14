import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/shared/widgets/buttons/custom_button.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);
  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  dynamic appModelTheme;

  //Locale selectedLocale = Locale('en');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('Inside init state of choose language screen');
    var lang = Provider.of<AppModel>(context, listen: false).fetchLocale();
    log('Selected language: $lang');
  }

  @override
  Widget build(BuildContext context) {
    log('Inside build of choose language');
    final appModel = Provider.of<AppModel>(context);

    //appModel.fetchLocale();

    appModelTheme = appModel;
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: () => Scaffold(
        backgroundColor: appModelTheme.darkTheme ? Color(0xff252525) : white,
        body: Container(
          width: double.infinity,
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 340.h),
              Text(
                getTranslated("ChooseYour", context),
                style: TextStyle(
                  fontFamily: "Poppins5",
                  fontSize: 26.sp,
                ),
              ),
              Text(getTranslated("Preferred", context),
                  style: TextStyle(
                    fontFamily: "Poppins5",
                    fontSize: 26.sp,
                  )),
              SizedBox(height: 92.h),
              SizedBox(
                height: 58.h,
                child: CustomButton(
                  title: Text('English',
                      style: TextStyle(
                          fontFamily: "Montserrat2", fontSize: 16.sp)),
                  width: 0.8,
                  bgColor:
                      appModel.appLocal == Locale('en') ? logoBlue : grayE6E6E5,
                  borderColor: transparent,
                  callBackFunction: () {
                    setState(() {
                      // selectedLocale = Locale('en');
                      appModel.changeLanguage(Locale('en'));

                      // print(selectedLocale);

                      //applangColor = false;
                    });
                  },
                ),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                height: 58.h,
                child: CustomButton(
                  title: Text('عربي',
                      style: TextStyle(
                          fontFamily: "Montserrat2", fontSize: 26.sp)),
                  width: 0.8,
                  bgColor:
                      appModel.appLocal == Locale('ar') ? logoBlue : grayE6E6E5,
                  borderColor: transparent,
                  callBackFunction: () {
                    setState(() {
                      //applangColor = true;

                      //print(applangColor);
                      // selectedLocale = Locale('ar');
                      appModel.changeLanguage(Locale('ar'));

                      // print(selectedLocale);
                    });
                  },
                ),
              ),
              SizedBox(height: 61.h),
              SizedBox(
                height: 60.h,
                child: CustomButton(
                  title: Text(
                    getTranslated("Continue", context),
                    style: TextStyle(fontSize: 18.sp, fontFamily: 'Poppins1'),
                  ),
                  width: 0.8,
                  bgColor: appModelTheme.darkTheme ? darkmodeColor : logoBlue,
                  borderColor: appModelTheme.darkTheme
                      ? darkmodeColor
                      : buttonBlueBorder,
                  callBackFunction: () {
                    //appModel.changeLanguage(selectedLocale);

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
