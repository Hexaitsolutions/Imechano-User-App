import 'dart:convert';

import 'package:imechano/ui/modal/view_services_model.dart';
import 'package:imechano/ui/styling/config.dart';

import 'package:http/http.dart' as http;

class ViewServicesDataAPI {
  Future<ViewServiceModel?> onServicesDataApi(String jobNumber) async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.viewservice);
      dynamic postData = {
        'job_number': jobNumber,
      };

      final response =
          await http.post(strURL, body: json.encode(postData), headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return ViewServiceModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final viewServicesDataAPI = ViewServicesDataAPI();
