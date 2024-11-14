import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/car_brand_model.dart';
import 'package:imechano/ui/styling/config.dart';

class AllCarBrandApi {
  Future<CarBrandModel?> onCarBrandApi() async {
    try {
      final strURL = Uri.parse(Config.apiurl + Config.carbrand);

      final response = await http.post(strURL, headers: {
        'content-Type': 'application/json',
      });

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return CarBrandModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final allcarbrandApi = AllCarBrandApi();
