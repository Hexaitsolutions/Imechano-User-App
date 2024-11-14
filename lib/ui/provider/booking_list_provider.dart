// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/booking_list_model.dart';
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/styling/config.dart';

class BookingListApi {
  Future<dynamic> onBookingListApi(
      String customer_id,
      String status,
      String search,
      String start_date,
      String end_date,
      String category) async {
    try {
      print(customer_id);
      final uri = Uri.parse(Config.apiurl + Config.bookinglist);

      dynamic postData = {
        'customer_id': customer_id,
        'status': status,
        'search': search,
        'start_date': start_date,
        'end_date': end_date,
        'category': category
      };
      print(postData.toString());
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;

      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        print(responseJson.toString());

        return BookingListModel.fromJson(responseJson);
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
