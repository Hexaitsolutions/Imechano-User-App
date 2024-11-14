import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/service_data_delete.model.dart';
import 'package:imechano/ui/styling/config.dart';

class DeleteServiceAPI {
  Future<DeleteServiceModel?> onDeleteServiceListApi(String id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.deleteservice);

      dynamic postData = {
        'id': id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return DeleteServiceModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return DeleteServiceModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
