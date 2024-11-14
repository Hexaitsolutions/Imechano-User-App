import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/reject_booking_model.dart';
import 'package:imechano/ui/styling/config.dart';

class RejectBookingApi {
  Future<RejectBookingModel?> onRejectBookingApi(String bookingId) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.rejectbooking);

      dynamic postData = {
        'booking_id': bookingId,
      };
      final response = await http.post(uri,
          body: json.encode(postData),
          headers: {'content-Type': 'application/json'});

      dynamic responseJson;
      if (response.statusCode == 200) {
        responseJson = json.decode(response.body);
        return RejectBookingModel.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}

final rejectBookingApi = RejectBookingApi();
