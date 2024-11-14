
import 'dart:io';

import 'package:http/http.dart' as http;


import '../styling/config.dart';
// class UploadApi {
//   Future<bool> addImage(Map<String, String> body, String filepath) async {
//     String addimageUrl = Config.apiurl + Config.login;
//     Map<String, String> headers = {
//       'Content-Type': 'multipart/form-data',
//     };
//     var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
//       ..fields.addAll(body)
//       ..headers.addAll(headers)
//       ..files.add(await http.MultipartFile.fromPath('image', filepath));
//     var response = await request.send();
//     if (response.statusCode == 201) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }

class UploadApi {
  Future<dynamic> onUploadApi(
      String userId, File image) async {
    try {
      final uri = Uri.parse(Config.apiurl + Config.uploadprofile);

      dynamic postData = {
        'id': userId,
        'image': image,
      };
      //create multipart request for POST or PATCH method
      var request = http.MultipartRequest("POST", uri);
      //add text fields
      request.fields["id"] = userId;
      //create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath("image", image.path);
      //add multipart to request
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print('Uploading--------------------------');
      print(responseString);
      return responseString;
    } catch (exception) {
      print('exception---- $exception');
      return false;
    }
  }
}

final uploadApi = UploadApi();