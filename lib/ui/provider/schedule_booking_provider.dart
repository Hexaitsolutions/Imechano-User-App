import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:imechano/ui/styling/config.dart';

// ignore: camel_case_types
class ScheduleBookingAPI {
  // ignore: non_constant_identifier_names
  Future<dynamic> onschedulebooking(
      String jobnumber,
      String timedate,
      ) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.accept_delivery_request);
      final request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.fields.addAll({
        'job_number': jobnumber,
        'time_date': timedate,
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
        print("~~~~~ Schedule Booking RESPONSE ~~~~~");
        print(responseJson);
        // return CarBookingModal.fromJson(responseJson);
      } else {
        return null;
      }
    } catch (exception) {
      print('exception---- $exception');
      return null;
    }
  }
}
//     try {
//       // final uri = Uri.parse(Config.apiurl + Config.carbooking);

//       // dynamic postData = {
//       //   'customer_id': customerid,
//       //   'category_id': categoryid,
//       //   'sub_category_id': subcategoryid,
//       //   'item_id[]': jsonEncode([4]),
//       //   'time_date': timedate,
//       //   'address': address,
//       //   'total': total,
//       // };
//       // final response = await http.post(uri,
//       //     body: json.encode(postData),
//       //     headers: {'content-Type': 'application/json'});

//       dynamic responseJson;
//       if (response.statusCode == 200) {
//         responseJson = json.decode(response.body);
//         return CarBookingModal.fromJson(responseJson);
//       } else if (response.statusCode == 404) {
//         responseJson = json.decode(response.body);
//         return DataNotFoundModel.fromJson(responseJson);
//       } else {
//         return null;
//       }
//     } catch (exception) {
//       print('exception---- $exception');
//       return null;
//     }
//   }
// }

final schedulebookingApi = ScheduleBookingAPI();
