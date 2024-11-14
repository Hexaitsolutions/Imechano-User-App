import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/car_booking_model.dart';
import 'package:imechano/ui/styling/config.dart';

// ignore: camel_case_types
class CarBookingApi {
  // ignore: non_constant_identifier_names
  Future<dynamic> oncarbooking(
      String customerid,
      String categoryid,
      String subcategoryid,
      String itemid,
      String timedate,
      String address,
      String total,
      String carId) async {
    try {
      log("API FILE FIELDS");

      print('cutstp' + customerid);
      print('caafa' + categoryid);
      print('subca' + subcategoryid);
      print(itemid.toString());
      print(carId);
      print('tota' + total);
      final uri = Uri.parse(Config.apiurl + Config.carbooking);
      final request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.fields.addAll({
        'customer_id': customerid,
        'category_id': categoryid,
        'sub_category_id': subcategoryid,
        'item_id[]': itemid.toString(),
        'time_date': timedate,
        'address': address,
        'total': total,
        'car_id': carId,
      });

      log("API FIELDS");
      print(request.fields);

      final http.Response response = await http.Response.fromStream(
        await request.send(),
      );
      dynamic responseJson;

      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print("~~~~~ BOOKING RESPONSE ~~~~~");
        print(responseJson);
        return CarBookingModal.fromJson(responseJson);
      } else {
        log("I m in else");
        print(response.statusCode);
        return null;
      }
    } catch (exception) {
      print('exception----Shaoib $exception');
      return null;
    }
  }
}

final carbookingapi = CarBookingApi();
