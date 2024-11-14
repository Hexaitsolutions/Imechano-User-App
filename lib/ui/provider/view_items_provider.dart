import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:imechano/ui/styling/config.dart';

import '../modal/view_items_model.dart';

class ViewItemsDataAPI {
  Future<ViewItemsModel?> onViewItemsDataApi(String jobNumber) async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.viewitems);
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

        print("Got Data");
        print(responseJson);
        return ViewItemsModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final viewItemsDataAPI = ViewItemsDataAPI();
