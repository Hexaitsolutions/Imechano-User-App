// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/register_model.dart';
import 'package:imechano/ui/styling/config.dart';


import '../modal/otp_verify_model.dart';

class OtpVerifyApi {
  Future<dynamic> onOtpVerifyApi(String email, String OTP,String flag) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.otpverify);

      dynamic postData = {'email': email, 'otp': OTP, 'flag': flag};
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print("otp_verify_provider onOtpVerifyApi");
        print(responseJson.toString());
        if(flag == "2") return RegisterModel.fromJson(responseJson);
        return OtpVerifyModel.fromJson(responseJson);
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

final otpverifyApi = OtpVerifyApi();
