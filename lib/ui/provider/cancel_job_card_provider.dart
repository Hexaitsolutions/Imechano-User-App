import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:imechano/ui/modal/cancel_jobcard_model.dart';
import 'package:imechano/ui/styling/config.dart';

class CancelJobCardApi {
  Future<CancelJobCardModel?> onCancelJobCardApi(
    String jobNumber,
  ) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.cancel_jobcard);

      dynamic postData = {
        'job_number': jobNumber,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return CancelJobCardModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final cancelJobCardApi = CancelJobCardApi();
