import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefObj {
  static Box? preferences;
}

class SharedPref {
  static Future save(String key, value) async {
    try {
      return PrefObj.preferences!.put(key, json.encode(value));
    } catch (e) {
      return null;
    }
  }

  static Future read(String key) async {
    try {
      return PrefObj.preferences!.containsKey(key)
          ? json.decode(PrefObj.preferences!.get(key))
          : null;
    } catch (e) {
      return null;
    }
  }

  static Future remove(String key) async {
    return PrefObj.preferences!.delete(key);
  }
}

class AppPreference {
  static const THEME_SETTING = "THEMESETTING";

  setThemePref(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_SETTING, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_SETTING) ?? false;
  }
}
