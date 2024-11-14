// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/addcar_modelClass.dart';
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:imechano/ui/styling/global.dart';

class AddCarApi {
  Future<dynamic> onAddCarApi(
      String carId,
      String user_id,
      String model,
      String cylinder,
      String mileage,
      String model_year,
      String plate_number,
      String chases_number,
      String fuel_type,
      String branId,
      AddCarType type) async {
    if (type != AddCarType.edit) {
      try {
        final uri = Uri.parse(Config.apiurl + Config.addcar);
  
        dynamic postData = {
          'user_id': user_id,
          'model': model,
          'cylinder': cylinder,
          'mileage': mileage,
          'model_year': model_year,
          'plate_number': plate_number,
          'chases_number': chases_number,
          'fuel_type': fuel_type,
          'brand_id': branId
        };
        final response = await http.post(uri,
            body: json.encode(postData),
            headers: {'content-Type': 'application/json'});

        dynamic responseJson;
        if (response.statusCode == 200) {
          responseJson = json.decode(response.body);
          return addCarModel.fromJson(responseJson);
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
    } else {
      try {
        final uri = Uri.parse(Config.apiurl + Config.editcar);
        final request = http.MultipartRequest(
          'POST',
          uri,
        );
        request.fields.addAll({
          'id': carId,
          'user_id': user_id,
          'model': model,
          'cylinder': cylinder,
          'mileage': mileage,
          'model_year': model_year,
          'plate_number': plate_number,
          'chases_number': chases_number,
          'fuel_type': fuel_type,
          'brand_id': "2"
        });

        // ..headers.addAll({
        //   // 'Accept': 'application/json',
        //   'Content-Type': 'multipart/form-data',
        //   'Authorization':
        //       'Bearer ${sharedPreferences.getString(Config.token)}',
        // }
        // );
        final http.Response response = await http.Response.fromStream(
          await request.send(),
        );
        dynamic responseJson;
        if (response.statusCode == 200) {
          responseJson = json.decode(response.body);
          return addCarModel.fromJson(responseJson);
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
}
