import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../styling/config.dart';

class GenerateInvoiceProvider {
  static Future<bool> generateInvoice(String jobCardId, String deliveryCharges,
      String subTotal, int status) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.jobCardPayment);

      dynamic postData = {
        'job_card_id': jobCardId,
        'staff_id': '123456',
        'payment_method': 0,
        'delivery_charges': deliveryCharges,
        'sub_total': subTotal,
        'status': status
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        log('Inside if');
        responseJson = json.decode(response.body);
        log(responseJson.toString());
        if (responseJson['data']['staff_id'] != null &&
            responseJson['data']['staff_id'] != null) {
          return true;
        } else {
          return false;
        }
      } else {
        log('Inside else');
        log(responseJson.toString());
        return false;
      }
    } catch (exception) {
      log('exception---- $exception');
      return false;
    }
  }
}
