// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/edit_var_model.dart';
import 'package:imechano/ui/styling/config.dart';

class editecarapi {
  Future<dynamic> oneditemodel(
      String user_id,
      String model,
      String cylinder,
      String mileage,
      String model_year,
      String plate_number,
      String chases_number,
      String id) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.editcar);

      dynamic postData = {
        'user_id': user_id,
        'model': model,
        'cylinder': cylinder,
        'mileage': mileage,
        'model_year': model_year,
        'plate_number': plate_number,
        'chases_number': chases_number,
        'id': id,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return Editecarliatmodel.fromJson(responseJson);
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

final editemodelapi = editecarapi();
