import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/reset_password_model.dart';
import 'package:imechano/ui/styling/config.dart';

class ResetPasswordApi {
  Future<dynamic> onResetpasswordApi(
      String email, String mobileNumber, String password) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.resetpassword);

      dynamic postData = {
        'email': email,
        'mobile_number': mobileNumber,
        'password': password
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return ResetPasswordModel.fromJson(responseJson);
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

final resetpasswordApi = ResetPasswordApi();
