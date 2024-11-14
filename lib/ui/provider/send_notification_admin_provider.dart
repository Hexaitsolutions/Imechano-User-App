import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';

import 'package:imechano/ui/modal/send_notification_admin_modal.dart';
import 'package:imechano/ui/styling/config.dart';

class SendNotificationAdminApi {
  // ignore: non_constant_identifier_names
  Future<dynamic> onSendNotificationAdminApi(
      String title, String message) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.sendadmin);

      dynamic postData = {
        'title': title,
        'message': message,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print(response.body);
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

        return SendNotificationAdminModel.fromJson(responseJson);
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
