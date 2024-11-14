import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/cust_joblist_model.dart';
import 'package:imechano/ui/styling/config.dart';

class CustomerJobListAPI {
  // ignore: non_constant_identifier_names
  Future<CustomerJobListModel?> onCustomerJobListApi(String job_number) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.customerjobdetails);

      dynamic postData = {
        'job_number': job_number,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);

        return CustomerJobListModel.fromJson(responseJson);
      } else if (response.statusCode == 404) {
        responseJson = json.decode(response.body);
        return CustomerJobListModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
