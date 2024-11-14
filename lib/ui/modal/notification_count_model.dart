class NotificationCountModel {
  int? total;
  int? totalRead;
  int? totalUnread;

  NotificationCountModel({this.total, this.totalRead, this.totalUnread});

  NotificationCountModel.fromJson(Map<String, dynamic> json) {
    total = json['total'] ?? 0;
    totalRead = json['total_read'] ?? 0;
    totalUnread = json['total_unread'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_read'] = this.totalRead;
    data['total_unread'] = this.totalUnread;
    return data;
  }
}
