// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/user_profile_modal.dart';
import 'package:imechano/ui/styling/config.dart';

class UserProfileApi {
  Future<dynamic> onUserProfileApi(String user_id, String name, String email,
      String mobile_number, String dob, String gender) async {
    try {
      // final uri = Uri.parse(Config.apiurl + Config.userprofile);

      // dynamic postData = {
      //   'user_id': user_id,
      //   'name': name,
      //   'email': email,
      //   'mobile_number': mobile_number,
      //   'dob': dob,
      //   'gender': gender
      // };
      // final response = await http.post(uri,
      //     body: json.encode(postData),
      //     headers: {'content-Type': 'application/json'});

      // dynamic responseJson;
      // if (response.statusCode == 200) {
      //   print("status ok ");
      //   responseJson = json.decode(response.body);
      //   return UserProfileModel.fromJson(responseJson);
      // } else if (response.statusCode == 404) {
      //   responseJson = json.decode(response.body);
      //   return DataNotFoundModel.fromJson(responseJson);
      // } else {
      //   return null;
      // }

      final uri = Uri.parse(Config.apiurl + Config.userprofile);
      final request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.fields.addAll({
        'user_id': user_id,
        'name': name,
        'email': email,
        'mobile_number': mobile_number,
        'dob': dob,
        'gender': gender
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
      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return UserProfileModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return DataNotFoundModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
