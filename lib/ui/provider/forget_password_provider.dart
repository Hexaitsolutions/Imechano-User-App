import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/forget_password_model.dart';
import 'package:imechano/ui/styling/config.dart';

class ForgetPasswordApi {
  Future<dynamic> onForgetpasswordApi(String email, String mobileNumber) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.forgetpassword);

      dynamic postData = {
        'email': email,
        'mobile_number': mobileNumber,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
      print(response.body);
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return ForgetPasswordModel.fromJson(responseJson);
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

final forgetpasswordApi = ForgetPasswordApi();
