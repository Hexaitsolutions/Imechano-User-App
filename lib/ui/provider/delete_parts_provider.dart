import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/part_data_delete_model.dart';
import 'package:imechano/ui/styling/config.dart';

class DeletepartsAPI {
  // ignore: non_constant_identifier_names
  Future<DeletepartsModel?> onDeletePartsListApi(String id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.deleteparts);

      dynamic postData = {
        'id': id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return DeletepartsModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return DeletepartsModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
