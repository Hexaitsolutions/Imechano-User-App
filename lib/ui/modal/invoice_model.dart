class InvoiceModel {
  int? code;
  List<InvoiceData>? data;

  InvoiceModel({this.code, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <InvoiceData>[];
      json['data'].forEach((v) {
        data!.add(new InvoiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceData {
  int? id;
  int? carId;
  int? customerId;
  int? bookingId;
  String? garageId;
  String? jobNumber;
  String? categoryId;
  String? subCategoryId;
  String? itemId;
  String? description;
  String? carUpload;
  String? deliveryTime;
  String? address;
  String? customerBookingStatus;
  String? pickupStatus;
  String? deliveryStatus;
  String? adminStatus;
  String? total;
  String? delieveryCharges;
  String? paymentStatus;
  int? rejectStatus;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? subcategoryName;
  String? jobDate;
  String? carRegNumber;
  String? year;
  String? mileage;
  String? carMake;
  String? carModel;
  String? vinNumber;
  int? status;
  int? jobcardStatus;
  int? deliveryRequest;
  Customer? customer;
  int? invoiceId;
  int? invoiceableId;
  int? staffId;
  String? paymentMethod;
  String? paymentMethodString;
  String? deliveryCharges;
  String? subTotal;
  Car? car;
  List<Item>? items;

  InvoiceData(
      {this.id,
      this.carId,
      this.customerId,
      this.bookingId,
      this.garageId,
      this.jobNumber,
      this.categoryId,
      this.subCategoryId,
      this.itemId,
      this.description,
      this.carUpload,
      this.deliveryTime,
      this.address,
      this.customerBookingStatus,
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
      this.subcategoryName,
      this.jobDate,
      this.carRegNumber,
      this.year,
      this.mileage,
      this.carMake,
      this.carModel,
      this.vinNumber,
      this.status,
      this.jobcardStatus,
      this.deliveryRequest,
      this.customer,
      this.invoiceId,
      this.invoiceableId,
      this.staffId,
      this.paymentMethod,
      this.deliveryCharges,
      this.subTotal,
      this.car,
      this.paymentMethodString,
      this.items});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['car_id'];
    customerId = json['customer_id'];
    bookingId = json['booking_id'];
    garageId = json['garage_id'] ?? '';
    jobNumber = json['job_number'] ?? '';
    categoryId = json['category_id'] ?? '';
    subCategoryId = json['sub_category_id'] ?? '';
    itemId = json['item_id'] ?? '';
    description = json['description'] ?? '';
    carUpload = json['car_upload'] ?? '';
    deliveryTime = json['delivery_time'] ?? '';
    address = json['address'] ?? '';
    customerBookingStatus = json['customer_booking_status'] ?? '';
    pickupStatus = json['pickup_status'] ?? '';
    deliveryStatus = json['delivery_status'] ?? '';
    adminStatus = json['admin_status'] ?? '';
    total = json['total'] ?? '';
    delieveryCharges = json['delievery_charges'] ?? '';
    paymentStatus = json['payment_status'] ?? '';
    rejectStatus = json['reject_status'];
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    deletedAt = json['deleted_at'] ?? '';
    subcategoryName = json['subcategory_name'] ?? '';
    jobDate = json['job_date'] ?? '';
    carRegNumber = json['car_reg_number'] ?? '';
    year = json['year'] ?? '';
    mileage = json['mileage'] ?? '';
    carMake = json['car_make'] ?? '';
    carModel = json['car_model'] ?? '';
    vinNumber = json['vin_number'] ?? '';
    status = json['status'];
    jobcardStatus = json['jobcard_status'];
    deliveryRequest = json['delivery_request'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    invoiceId = json['invoice_id'];
    invoiceableId = json['invoiceable_id'];
    staffId = json['staff_id'];
    //GET PAYMENT METHOD STRING
    switch (json['payment_method']) {
      case null:
        paymentMethod = '';
        break;
      case 0:
        paymentMethod = 'Pending';
        break;
      case 1:
        paymentMethod = 'Cash';
        break;
      case 2:
        paymentMethod = 'POS';
        break;
      case 3:
        paymentMethod = 'Online Payment';
        break;
    }
    deliveryCharges = json['delivery_charges'] ?? '';
    subTotal = json['sub_total'] ?? '';
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    if (json['item'] != null) {
      items = <Item>[];
      json['item'].forEach((v) {
        items!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_id'] = this.carId;
    data['customer_id'] = this.customerId;
    data['booking_id'] = this.bookingId;
    data['garage_id'] = this.garageId;
    data['job_number'] = this.jobNumber;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['item_id'] = this.itemId;
    data['description'] = this.description;
    data['car_upload'] = this.carUpload;
    data['delivery_time'] = this.deliveryTime;
    data['address'] = this.address;
    data['customer_booking_status'] = this.customerBookingStatus;
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
    data['subcategory_name'] = this.subcategoryName;
    data['job_date'] = this.jobDate;
    data['car_reg_number'] = this.carRegNumber;
    data['year'] = this.year;
    data['mileage'] = this.mileage;
    data['car_make'] = this.carMake;
    data['car_model'] = this.carModel;
    data['vin_number'] = this.vinNumber;
    data['status'] = this.status;
    data['jobcard_status'] = this.jobcardStatus;
    data['delivery_request'] = this.deliveryRequest;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['invoice_id'] = this.invoiceId;
    data['invoiceable_id'] = this.invoiceableId;
    data['staff_id'] = this.staffId;
    data['payment_method'] = this.paymentMethod;
    data['delivery_charges'] = this.deliveryCharges;
    data['sub_total'] = this.subTotal;
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    if (this.items != null) {
      data['item'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? longitude;
  String? latitude;

  Customer(
      {this.id,
      this.name,
      this.email,
      this.mobileNumber,
      this.longitude,
      this.latitude});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class Car {
  String? carImage;
  String? carBrand;
  String? carModel;
  String? carYear;
  String? carChasis;
  String? carName;
  String? carMileage;
  String? carCylinder;
  String? plateNo;
  String? vinNo;

  Car(
      {this.carImage,
      this.carBrand,
      this.carModel,
      this.carYear,
      this.carChasis,
      this.carName,
      this.carMileage,
      this.carCylinder,
      this.plateNo,
      this.vinNo});

  Car.fromJson(Map<String, dynamic> json) {
    carImage = json['car_image'] ?? '';
    carBrand = json['car_brand'] ?? '';
    carModel = json['car_model'] ?? '';
    carYear = json['car_year'] ?? '';
    carChasis = json['car_chasis'] ?? '';
    carName = json['car_name'] ?? '';
    carMileage = json['car_mileage'] ?? '';
    carCylinder = json['car_cylinder'] ?? '';
    plateNo = json['car_plate_no'] ?? '';
    vinNo = json['vin_number'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_image'] = this.carImage;
    data['car_brand'] = this.carBrand;
    data['car_model'] = this.carModel;
    data['car_year'] = this.carYear;
    data['car_chasis'] = this.carChasis;
    data['car_name'] = this.carName;
    data['car_mileage'] = this.carMileage;
    data['car_cylinder'] = this.carCylinder;
    return data;
  }
}

class Item {
  int? id;
  int? subCategoryId;
  String? itemName;
  String? itemAr;
  String? itemPrice;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Item(
      {this.id,
      this.subCategoryId,
      this.itemName,
      this.itemAr,
      this.itemPrice,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryId = json['sub_category_id'];
    itemName = json['item'];
    itemAr = json['item_ar'];
    itemPrice = json['price'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_id'] = this.subCategoryId;
    data['item'] = this.itemName;
    data['item_ar'] = this.itemAr;
    data['price'] = this.itemPrice;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
