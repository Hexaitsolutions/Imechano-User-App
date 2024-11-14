import 'dart:developer';

class CustomerNotificationListModel {
  String? code;
  String? message;
  List<Data>? data;

  CustomerNotificationListModel({this.code, this.message, this.data});

  CustomerNotificationListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data']['data'] != null) {
      data = <Data>[];
      json['data']['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? carId;
  String? customerId;
  String? adminId;
  String? status;
  String? jobNo;
  String? title;
  String? message;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
      this.carId,
      this.customerId,
      this.adminId,
      this.status,
      this.title,
      this.jobNo,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    carId = json['car_id'].toString();
    customerId = json['customer_id'].toString();
    adminId = json['admin_id'].toString();
    status = json['status'].toString();
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
    if (json['notifiable'] != null) {
      jobNo = json['notifiable']['job_number'];
    }

    log('Got got no from api in notifications: $jobNo');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_id'] = this.carId;
    data['customer_id'] = this.customerId;
    data['admin_id'] = this.adminId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
