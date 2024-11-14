import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:imechano/ui/common/globals.dart';
import 'package:imechano/ui/modal/car_booking_model.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:imechano/ui/styling/global.dart';

// ignore: camel_case_types
class carCheckupbookingApis {
  // ignore: non_constant_identifier_names
  Future<dynamic> carCheckupbooking(
      String customerid,
      String timedate,
      String address,
      String carId,
      String workdone,
      List<XFile>? imagefiles) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.checkupbooking);
      final request = http.MultipartRequest(
        'POST',
        uri,
      );
      List<http.MultipartFile> files = [];
      if (imagefiles != null) {
        for (XFile element in imagefiles) {
          XFile compressedFile = await compressImage(element);

          var file = await http.MultipartFile.fromPath(
              'images[]', compressedFile.path);
          files.add(file);
        }
        request.files.addAll(files);
      }

      log('Img Files: $files');
      log('Description: $workdone');
      request.fields.addAll({
        'customer_id': customerid,
        'time_date': timedate,
        'address': address,
        'car_id': carId,
        'description': workdone,
        'car_upload': files.toString()
      });

      // ..headers.addAll({
      //   // 'Accept': 'application/json',
      //   'Content-Type': 'multipart/form-data',
      //   'Authorization':
      //       'Bearer ${sharedPreferences.getString(Config.token)}',
      // }
      // );
      final http.Response response = await http.Response.fromStream(
        await request.send(),
      );
      // log(response.statusCode.toString());
      // log(response.body);

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print("~~~~~ BOOKING RESPONSE ~~~~~");
        print(responseJson);
        return CarBookingModal.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      BuildContext context = Get.context!;
      snackBar('Image size is too large', context);
      print('exception---- $exception');
      return null;
    }
  }
}

final CarCheckupbookingApi = carCheckupbookingApis();
