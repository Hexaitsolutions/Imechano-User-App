class CustomerInvoiceModel {
  int? code;
  String? message;
  List<Data>? data;

  CustomerInvoiceModel({this.code, this.message, this.data});

  CustomerInvoiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
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
  int? id;
  String? carId;
  String? bookingId;
  String? customerId;
  String? garageId;
  String? jobNumber;
  String? categoryId;
  String? subCategoryId;
  String? itemId;
  String? carUpload;
  String? description;
  String? timeDate;
  String? deliveryTime;
  String? address;
  String? status;
  String? pickupStatus;
  String? deliveryStatus;
  String? adminStatus;
  String? total;
  String? delieveryCharges;
  String? paymentStatus;
  String? rejectStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? jobCardStatus;
  String? subcategoryName;
  List<Items>? items;
  CarDetails? carDetails;

  Data(
      {this.id,
      this.carId,
      this.bookingId,
      this.customerId,
      this.garageId,
      this.jobNumber,
      this.categoryId,
      this.subCategoryId,
      this.itemId,
      this.carUpload,
      this.description,
      this.timeDate,
      this.deliveryTime,
      this.address,
      this.status,
      this.pickupStatus,
      this.deliveryStatus,
      this.adminStatus,
      this.total,
      this.delieveryCharges,
      this.paymentStatus,
      this.rejectStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.jobCardStatus,
      this.subcategoryName,
      this.items,
      this.carDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    json['car_id'] != null ? carId = json['car_id'].toString() : carId = "";
    json['booking_id'] != null ? bookingId = json['booking_id'].toString() : bookingId = "";
    json['customer_id'] != null ? customerId = json['customer_id'].toString() : customerId = "";
    json['garage_id'] != null ? garageId = json['garage_id'] : garageId = "";
    jobNumber = json['job_number'] ?? " ";
    categoryId = json['category_id'] ?? " ";
    subCategoryId = json['sub_category_id'] ?? " ";
    itemId = json['item_id'] ?? " ";
    carUpload = json['car_upload'] ?? "";
    description = json['description'] ?? " ";
    timeDate = json['time_date'] ?? " ";
    deliveryTime = json['delivery_time'] ?? " ";
    address = json['address'] ?? " ";
    status = json['status'] ?? " ";
    pickupStatus = json['pickup_status'] ?? "";
    deliveryStatus = json['delivery_status'] ?? " ";
    adminStatus = json['admin_status'] ?? " ";
    total = json['total'] ?? " ";
    delieveryCharges = json['delievery_charges'] ?? " ";
    paymentStatus = json['payment_status'] ?? " ";
  //  rejectStatus = json['reject_status'] ?? " ";
    json['reject_status'] != null ? rejectStatus = json['reject_status'].toString() : rejectStatus = "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? " ";
    jobCardStatus = json['job_card_status'] ?? " ";
    subcategoryName = json['subcategory_name'] ?? " ";
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    carDetails = json['car_details'] != null
        ? new CarDetails.fromJson(json['car_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_id'] = this.carId;
    data['booking_id'] = this.bookingId;
    data['customer_id'] = this.customerId;
    data['garage_id'] = this.garageId;
    data['job_number'] = this.jobNumber;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['item_id'] = this.itemId;
    data['car_upload'] = this.carUpload;
    data['description'] = this.description;
    data['time_date'] = this.timeDate;
    data['delivery_time'] = this.deliveryTime;
    data['address'] = this.address;
    data['status'] = this.status;
    data['pickup_status'] = this.pickupStatus;
    data['delivery_status'] = this.deliveryStatus;
    data['admin_status'] = this.adminStatus;
    data['total'] = this.total;
    data['delievery_charges'] = this.delieveryCharges;
    data['payment_status'] = this.paymentStatus;
    data['reject_status'] = this.rejectStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['job_card_status'] = this.jobCardStatus;
    data['subcategory_name'] = this.subcategoryName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.carDetails != null) {
      data['car_details'] = this.carDetails!.toJson();
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
    json['price'] != null ? price = json['price'] : price = "";
    description = json['description'] ?? " ";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? " ";
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

class CarDetails {
  int? id;
  String? userId;
  String? brandId;
  String? model;
  String? cylinder;
  String? mileage;
  String? modelYear;
  String? plateNumber;
  String? chasesNumber;
  String? fuelType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? brand;

  CarDetails(
      {this.id,
      this.userId,
      this.brandId,
      this.model,
      this.cylinder,
      this.mileage,
      this.modelYear,
      this.plateNumber,
      this.chasesNumber,
      this.fuelType,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.brand});

  CarDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    json['user_id'] != null ? userId = json['user_id'].toString() : userId ="";
    json['brand_id'] != null ? brandId = json['brand_id'].toString() : brandId = "";
  
    model = json['model'] ?? " ";
    cylinder = json['cylinder'] ?? " ";
    mileage = json['mileage'] ?? " ";
    modelYear = json['model_year'] ?? " ";
    plateNumber = json['plate_number'] ?? " ";
    chasesNumber = json['chases_number'] ?? " ";
    fuelType = json['fuel_type'] ?? " ";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? " ";
    brand = json['brand'] ?? " ";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['brand_id'] = this.brandId;
    data['model'] = this.model;
    data['cylinder'] = this.cylinder;
    data['mileage'] = this.mileage;
    data['model_year'] = this.modelYear;
    data['plate_number'] = this.plateNumber;
    data['chases_number'] = this.chasesNumber;
    data['fuel_type'] = this.fuelType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['brand'] = this.brand;
    return data;
  }
}
