class CarBookingModal {
  String? code;
  String? message;
  Data? data;

  CarBookingModal({this.code, this.message, this.data});

  CarBookingModal.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? bookingId;
  String? carId;
  String? customerId;
  String? categoryId;
  String? subCategoryId;
  String? itemId;
  String? timeDate;
  String? address;
  String? total;
  String? status;
  String? updatedAt;
  String? createdAt;
  String? id;
  String? subcategoryName;
  List<Items>? items;

  Data(
      {this.bookingId,
      this.carId,
      this.customerId,
      this.categoryId,
      this.subCategoryId,
      this.itemId,
      this.timeDate,
      this.address,
      this.total,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.subcategoryName,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'].toString();
    carId = json['car_id'] ?? "";
    customerId = json['customer_id'].toString();
    categoryId = json['category_id'].toString();
    subCategoryId = json['sub_category_id'].toString();
    itemId = json['item_id'];
    timeDate = json['time_date'];
    address = json['address'] ?? "";
    total = json['total'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'].toString();
    subcategoryName = json['subcategory_name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['car_id'] = this.carId;
    data['customer_id'] = this.customerId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['item_id'] = this.itemId;
    data['time_date'] = this.timeDate;
    data['address'] = this.address;
    data['total'] = this.total;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['subcategory_name'] = this.subcategoryName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
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
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? "";
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
