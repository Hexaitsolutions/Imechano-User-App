import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/select-car-details_model.dart';
import 'package:imechano/ui/styling/config.dart';

class CarDetailsApi {
  // ignore: non_constant_identifier_names
  Future<dynamic> onCarDetailsApi(String car_id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.cardetails);

      dynamic postData = {
        'car_id': car_id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return CarDetailsModel.fromJson(responseJson);
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
