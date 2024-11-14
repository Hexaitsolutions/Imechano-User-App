class PickupConditionsListModel {
  String? code;
  String? message;
  List<Data>? data;

  PickupConditionsListModel({this.code, this.message, this.data});

  PickupConditionsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'] == null ? null : json['code'];
    message = json['message'] == null ? null : json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }else{
      data = null;
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
  String? label;
  String? carImage;
  String? carCondition;
  String? workNeeded;
  String? bookingId;
  String? updatedAt;
  String? createdAt;
  String? id;

  Data(
      {this.label,
        this.carImage,
      this.carCondition,
      this.workNeeded,
      this.bookingId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label'] == null ? null : json['label'];
    carImage = json['car_image'] == null ? null : json['car_image'];
    carCondition = json['car_conditions'] == null ? null : json['car_conditions'];
    workNeeded = json['work_needed'] == null ? null : json['work_needed'];
    bookingId = json['booking_id'] == null ? null : json['booking_id'].toString();
    updatedAt = json['updated_at'] == null ? null : json['updated_at'];
    createdAt = json['created_at'] == null ? null : json['craeted_at'];
    id = json['id'] == null ? null : json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['car_image'] = this.carImage;
    data['car_conditions'] = this.carCondition;
    data['work_needed'] = this.workNeeded;
    data['booking_id'] = this.bookingId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
