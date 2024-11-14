import 'package:intl/intl.dart';

class BookingListModel {
  String? code;
  String? message;
  List<ItemData>? data;

  BookingListModel({this.code, this.message, this.data});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <ItemData>[];
      json['data'].forEach((v) {
        data!.add(new ItemData.fromJson(v));
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

class ItemData {
  String? id;
  String? carName;
  String? jobNo;
  String? carId;
  String? bookingId;
  String? customerId;
  String? categoryId;
  String? subCategoryId;
  String? itemId;
  String? carUpload;
  String? timeDate;
  String? address;
  String? status;
  String? adminStatus;
  String? pickupStatus;
  String? paymentStatus;
  String? deliveryCharges;
  String? total;
  String? bookingTime;
  String? updatedAt;
  String? deletedAt;
  String? subcategoryName;
  List<Items>? items;
  bool? payconfirm;
  bool? cancelorder;
  bool? confirmedpickup;

  ItemData(
      {this.id,
      this.carName,
      this.carId,
      this.jobNo,
      this.bookingId,
      this.customerId,
      this.categoryId,
      this.subCategoryId,
      this.itemId,
      this.carUpload,
      this.timeDate,
      this.address,
      this.status,
      this.adminStatus,
      this.pickupStatus,
      this.paymentStatus,
      this.deliveryCharges,
      this.total,
      this.bookingTime,
      this.updatedAt,
      this.deletedAt,
      this.subcategoryName,
      this.items,
      this.payconfirm,
      this.cancelorder,
      this.confirmedpickup});

  ItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    carName = json["car_name"];
    carId = json['car_id'].toString();
    jobNo = json['job_number'] ?? '';
    bookingId = json['booking_id'].toString();
    customerId = json['customer_id'].toString();
    categoryId = json['category_id'].toString();
    subCategoryId = json['sub_category_id'].toString();
    itemId = json['item_id'];
    carUpload = json['car_upload'] ?? '';
    timeDate = json['time_date'];
    address = json['address'] ?? '';
    status = json['status'];
    adminStatus = json['admin_status'];
    pickupStatus = json['pickup_status'];
    paymentStatus = json['payment_status'];
    deliveryCharges = json['delievery_charges'] ?? '';
    total = json['total'];
    bookingTime = json['created_at'];
    DateTime parsedDate = DateTime.parse(bookingTime!).toLocal();
    String formattedDate = DateFormat('yyyy/MM/dd HH:mm').format(parsedDate);
    bookingTime = formattedDate;
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? "";
    subcategoryName = json['subcategory_name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    payconfirm = true;
    cancelorder = true;
    confirmedpickup = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_name'] = this.carName;
    data['car_id'] = this.carId;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['item_id'] = this.itemId;
    data['car_upload'] = this.carUpload;
    data['time_date'] = this.timeDate;
    data['address'] = this.address;
    data['status'] = this.status;
    data['admin_status'] = this.adminStatus;
    data['pickup_status'] = this.pickupStatus;
    data['payment_status'] = this.paymentStatus;
    data['total'] = this.total;
    data['created_at'] = this.bookingTime;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['subcategory_name'] = this.subcategoryName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['payconfirm'] = this.payconfirm;
    data['cancelorder'] = this.cancelorder;
    data['confirmedpickup'] = this.confirmedpickup;
    return data;
  }
}

class Items {
  int? id;
  String? subCategoryId;
  String? item;
  String? price;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Items(
      {this.id,
      this.subCategoryId,
      this.item,
      this.price,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryId = json['sub_category_id'].toString();
    item = json['item'];
    price = json['price'];
    description = json['description'] ?? '';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_id'] = this.subCategoryId;
    data['item'] = this.item;
    data['price'] = this.price;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
