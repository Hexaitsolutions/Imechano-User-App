class ViewItemsModel {
  String? code;
  String? message;
  List<Data>? data;

  ViewItemsModel({this.code, this.message, this.data});

  ViewItemsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
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
  String? itemId;
  String? bookingId;
  String? status;
  String? name;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.itemId,
      this.bookingId,
      this.status,
      this.name,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    bookingId = json['booking_id'].toString();
    name = json['name'];
    status = json['status'];
    itemId = json['item_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['item_id'] = this.itemId;
    data['status'] = this.status;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
