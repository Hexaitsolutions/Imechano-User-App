import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/share_preferences/preference.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppModel extends ChangeNotifier {
  AppPreference appPreference = AppPreference();
  bool checkCon = false;
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  //String languageApp = 'en';

  set darkTheme(bool value) {
    _darkTheme = value;
    appPreference.setThemePref(value);
    notifyListeners();
  }

  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale;

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('language_code') == "en") {
      _appLocale = Locale('en');
    } else if (prefs.getString('language_code') == "ar") {
      _appLocale = Locale('ar');
      langSwitch = true;
    }
  }

  void changeLanguage(Locale type) async {
    print("My Language is ");
    log(_appLocale.toString());
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      print("GOOD");
      return;
    }
    if (type == Locale("ar")) {
      print("good");
      _appLocale = Locale("ar");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }

    log("Language changed: $appLocal");
    log(prefs.getString('language_code')!);
    Get.updateLocale(appLocal);

    notifyListeners();
  }
}
