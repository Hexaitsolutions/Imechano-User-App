// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/data_not_found_modal.dart';
import 'package:imechano/ui/modal/invoice_model.dart';
import 'package:imechano/ui/styling/config.dart';

class ListOfInvoicesApi {
  Future<dynamic> onListOfInvoicesApi(String customer_id, String status,
      String startDate, String endDate) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.listOfInvoices);

      dynamic postData = {
        'customer_id': customer_id,
        'status': status,
        'start_date': startDate,
        'end_date': endDate
      };
      log(postData.toString());

// Encode parameters in the query string

//String queryString = Uri(queryParameters: postData).query;
      // Create a full URI with query parameters
      // final fullUri = Uri.parse('$uri?$queryString');

      

      String queryString = Uri(queryParameters: postData).query;
      final fullUri = Uri.parse('$uri?$queryString');

      final response = await http
          .get(fullUri, headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      log("~~~ List of Invoices ~~~");
      log("Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        // log(responseJson.toString());
        return InvoiceModel.fromJson(responseJson);
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
