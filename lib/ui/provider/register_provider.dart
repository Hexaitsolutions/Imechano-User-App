// ignore_for_file: null_check_always_fails

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/register_model.dart';
import 'package:imechano/ui/styling/config.dart';

class UserRegisterDetailsApi {
  Future<dynamic> onUserRegisterAPI(
      String email,
      String mobileNumber,
      String name,
      String latitude,
      String longitude,
      String password,
      String fcmToken,
      String resendOTP) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.registered);
      final request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.fields.addAll({
        'email': email,
        'mobile_number': mobileNumber,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'password': password,
        'otp': '1234',
        'role': "2",
        'firebase_token': fcmToken,
        'resend_otp':resendOTP
      });

      Map<String, String> headers = {
        'Content-Type': 'Content-Type',
        'Accept': 'application/json'
      };
      request.headers.addAll(headers);

      final http.Response response = await http.Response.fromStream(
        await request.send(),
      );
      dynamic responseJson;
      if (response.statusCode == 200) {
        print(response.statusCode);
        responseJson = json.decode(response.body);
        print(responseJson);
        return RegisterModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final userregisterdetailsApi = UserRegisterDetailsApi();



// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:imechano/ui/modal/data_not_found_modal.dart';
// import 'package:imechano/ui/modal/register_model.dart';
// import 'package:imechano/ui/styling/config.dart';

// class RegisterFirstApi {
//   Future<dynamic> onRegisterFirstApi(
//     String email,
//     String mobileNumber,
//     String name,
//     String emailVerifiedAt,
//   ) async {
//     try {
//       dynamic postData;
//       final uri = Uri.parse(Config.apiurl + Config.registered);
//       final request = http.MultipartRequest(
//         'POST',
//       )
//       postData = {
//         'email': email,
//         'phone': mobileNumber,
//         'name': name,
//         'password': emailVerifiedAt,
//       };

//       final response = await http.post(uri,
//           body: json.encode(postData),
//           headers: {'content-Type': 'application/json'});

//       dynamic responseJson;
//       if (response.statusCode == 200) {
//         responseJson = json.decode(response.body);
//         return RegisterModel.fromJson(responseJson);
//       } else if (response.statusCode == 404) {
//         responseJson = json.decode(response.body);
//         return DataNotFoundModel.fromJson(responseJson);
//       } else {
//         return null;
//       }
//     } catch (exception) {
//       print('exception---- $exception');
//       return null;
//     }
//   }
// }

// final registerFirstApi = RegisterFirstApi();
