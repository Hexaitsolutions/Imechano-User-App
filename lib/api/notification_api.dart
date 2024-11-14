import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:imechano/ui/modal/customer_notification_list_model.dart';
import 'package:imechano/ui/modal/notification_count_model.dart';
import 'package:imechano/ui/share_preferences/pref_key.dart';
import 'package:imechano/ui/share_preferences/preference.dart';
import 'package:imechano/ui/styling/config.dart';
import 'package:imechano/utils/utils.dart';

class NotificationApi {
  static Future<NotificationCountModel> getNotificationCount() async {
    NotificationCountModel notificationCountModel =
        NotificationCountModel(total: 0, totalRead: 0, totalUnread: 0);
    try {
      final userId = await PrefObj.preferences!.get(PrefKeys.USER_ID);
      final uri = Uri.parse(Config.apiurl + Config.notification_list);
      final response = await http.post(uri, body: {'customer_id': userId});

      //log('Status code: ${response.statusCode}');
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['code'] == 1) {
        notificationCountModel =
            NotificationCountModel.fromJson(responseData['data']);
      }
    } catch (e) {
      log(e.toString());
    }

    log('Total unread: ${notificationCountModel.totalUnread}');
    return notificationCountModel;
  }

  static Future<bool> updateNotificationStatus(Data notificationModel,
      {bool read = true}) async {
    bool updated = false;
    try {
      final uri = Uri.parse(Config.apiurl + Config.updateNotificationStatus);
      final response = await http.post(uri, body: {
        'id': notificationModel.id,
        'user_id': notificationModel.customerId,
        'status': read ? '1' : '0'
      });

      //log('Status code: ${response.statusCode}');
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['code'] == 1) {
        updated = true;
      }
    } catch (e) {
      log(e.toString());
    }
    return updated;
  }

  static Future<bool> deleteAllNotifications() async {
    bool deleted = false;
    try {
      final userId = await PrefObj.preferences!.get(PrefKeys.USER_ID);
      final uri = Uri.parse(Config.apiurl + Config.deleteNotifications);
      final response = await http.post(uri, body: {'user_id': userId});

      //log('Status code: ${response.statusCode}');
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['code'] == 1) {
        deleted = true;
      }
      String message = responseData['message'] ?? 'Please try again';
      Utils.showToast(message);
    } catch (e) {
      log(e.toString());
    }

    return deleted;
  }
}
