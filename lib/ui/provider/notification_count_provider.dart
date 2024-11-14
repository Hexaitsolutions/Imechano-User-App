import 'package:flutter/material.dart';
import 'package:imechano/api/notification_api.dart';
import 'package:imechano/ui/modal/notification_count_model.dart';

class NotificationCountProvider with ChangeNotifier {
  NotificationCountModel _notifications =
      NotificationCountModel(total: 0, totalRead: 0, totalUnread: 0);

  int get notifications => _notifications.totalUnread!;

  Future<void> setNotifications() async {
    _notifications = await NotificationApi.getNotificationCount();
    notifyListeners();
  }

  void clearNotifications() async {
    _notifications =
        NotificationCountModel(total: 0, totalRead: 0, totalUnread: 0);
  }
}
