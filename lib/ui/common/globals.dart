library globals;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/styling/config.dart';
import 'package:intl/intl.dart';

var other = [];
bool langSwitch = false;
Size? screenSize;
int screenstack = 0;
int currentBookingTab = 0;
int currentInvoiceTab = 0;
List indexed = [];

int currentJobcardTab = 0;
List itemId = [];
List itemName = [];
List itemPrice = [];
List cart = [];
int currentCount = 0;
Map selectedService = {};
String catogoryName = "";
List sselected = [];
var numberFormat = NumberFormat('#,##0.00', 'en_US');
List catogoryNames = [];

void setScreenSize(var size) {
  screenSize = size;
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    String message, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ),
  );
}

void changeLocale(String id, locale) async {
  final uri = Uri.parse(Config.apiurl + "change-user-locale");

  dynamic postData = {
    'id': id,
    'locale': locale,
  };
  print(postData.toString());
  final response = await http.post(uri,
      body: json.encode(postData),
      headers: {'content-Type': 'application/json'});

  dynamic responseJson;

  if (response.statusCode == 200) {
    print("Good Hougaya");
  } else if (response.statusCode == 404) {
    print("ohoo");
  } else {
    return null;
  }
}
