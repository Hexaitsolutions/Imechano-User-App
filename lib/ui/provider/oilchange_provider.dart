import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/oilchange_model.dart';
import 'package:imechano/ui/styling/config.dart';

class OilchangeApi {
  // ignore: non_constant_identifier_names
  Future<dynamic> onOilchangeApi(String category_id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.oilchange);

      dynamic postData = {
        'category_id': category_id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        print("status pppppp ");
        responseJson = json.decode(response.body);
        return OilChangeModel.fromJson(responseJson);
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
