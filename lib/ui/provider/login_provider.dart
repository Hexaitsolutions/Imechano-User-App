import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/login_modal.dart';
import 'package:imechano/ui/styling/config.dart';

class LoginApi {
  Future<dynamic> onLoginApi(
      String mobileNumber, String password, String fcmToken) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.login);

      dynamic postData = {
        'email_mobile': mobileNumber,
        'password': password,
        'firebase_token': fcmToken,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      print(response.body.toString());
      if (response.statusCode == 200) {
        print("12112${response.statusCode}");
        responseJson = json.decode(response.body);
        return LoginModal.fromJson(responseJson);
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

final loginApi = LoginApi();
