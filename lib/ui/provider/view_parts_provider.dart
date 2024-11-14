import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/view_parts_model.dart';
import 'package:imechano/ui/styling/config.dart';

class ViewPartsDataAPI {
  Future<ViewPartsModel?> onViewpartsDataApi(String jobNumber) async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.viewparts);
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
        return ViewPartsModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final viewPartsDataAPI = ViewPartsDataAPI();
