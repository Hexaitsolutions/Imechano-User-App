import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/categoriesModelClass.dart';
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/styling/config.dart';

class CategoriesApi {
  // ignore: non_constant_identifier_names
  Future<dynamic> onCategoriesApi(String brand_id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.categories);

      dynamic postData = {
        'search': brand_id == "null" ? null : brand_id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});
      print(response.statusCode);
      print(response.body);

      dynamic responseJson;
      if (response.statusCode == 200) {
        print("status ok ");
        responseJson = json.decode(response.body);
        return CategoriesModelClass.fromJson(responseJson);
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
