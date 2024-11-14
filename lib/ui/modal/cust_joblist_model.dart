class CustomerJobListModel {
  String? code;
  String? message;
  List<Data>? data;

  CustomerJobListModel({this.code, this.message, this.data});

  CustomerJobListModel.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? updated_at;
  String? bookingId;
  String? jobNumber;
  String? jobDate;
  String? customerName;
  String? customerContactNo;
  String? carRegNumber;
  String? year;
  String? mileage;
  String? dateTime;
  String? carMake;
  String? carModel;
  String? vinNumber;
  String? total;
  String? subcategoryName;
  String? deliveryRequest;
  List<Items>? items;

  Data(
      {this.id,
      this.updated_at,
      this.status,
      this.bookingId,
      this.jobNumber,
      this.jobDate,
      this.customerName,
      this.customerContactNo,
      this.carRegNumber,
      this.year,
      this.deliveryRequest,
      this.mileage,
      this.dateTime,
      this.carMake,
      this.carModel,
      this.vinNumber,
      this.total,
      this.subcategoryName,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    status = json['status'];
    updated_at = json['updated_at'];
    bookingId = json['booking_id'].toString();
    jobNumber = json['job_number'].toString();
    jobDate = json['job_date'];
    customerName = json['customer_name'];
    customerContactNo = json['customer_contact_no'];
    carRegNumber = json['car_reg_number'];
    year = json['year'];
    mileage = json['mileage'];
    dateTime = json['date_time'];
    carMake = json['car_make'];
    carModel = json['car_model'];
    deliveryRequest = json['delivery_request'].toString();
    vinNumber = json['vin_number'];
    total = json['total'];
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
    data['id'] = this.id;
    data['updated_at'] = this.updated_at;
    data['status'] = this.status;
    data['booking_id'] = this.bookingId;
    data['job_number'] = this.jobNumber;
    data['job_date'] = this.jobDate;
    data['customer_name'] = this.customerName;
    data['customer_contact_no'] = this.customerContactNo;
    data['car_reg_number'] = this.carRegNumber;
    data['year'] = this.year;
    data['mileage'] = this.mileage;
    data['date_time'] = this.dateTime;
    data['car_make'] = this.carMake;
    data['car_model'] = this.carModel;
    data['vin_number'] = this.vinNumber;
    data['total'] = this.total;
    data['subcategory_name'] = this.subcategoryName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? item;
  String? price;
  String? description;

  Items({this.id, this.item, this.price, this.description});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    item = json['item'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item'] = this.item;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
