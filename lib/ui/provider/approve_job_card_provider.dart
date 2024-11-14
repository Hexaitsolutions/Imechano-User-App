import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/approve_jobcard_model.dart';
import 'package:imechano/ui/styling/config.dart';

class ApproveJobCardApi {
  Future<ApproveJobCardModel?> onApproveJobCardApi(
    String jobNumber,
  ) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.approve_jobcard);

      dynamic postData = {
        'job_number': jobNumber,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      log('Status: ${response.statusCode}');
      log('Got responsee from approvve job card: $response');
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return ApproveJobCardModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final acceptBookingApi = ApproveJobCardApi();
