import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../modal/pickup_conditions_list_model.dart';

import '../styling/config.dart';

class ConditionListApi {


  Future<PickupConditionsListModel?> listPickupConditions(String bookingId) async {
    try {
      final response = await http.post(
        Uri.parse(Config.apiurl + Config.pickup_condition_list),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'booking_id': bookingId,
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        return PickupConditionsListModel.fromJson(jsonDecode(response.body));
      }
    }catch (exception) {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print('exceptions---- $exception');
      return null;
    }
    return null;

  }

  // ignore: non_constant_identifier_names
  Future<dynamic> onConditionListApi(String booking_id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.pickup_condition_list);
      print(uri);
      dynamic postData = {
        'booking_id': booking_id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      print(responseJson);
      print(response);
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return responseJson;
        // return PickupConditionsListModel.fromJson(responseJson);
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
