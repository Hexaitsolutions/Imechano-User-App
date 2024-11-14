class CarDetailsModel {
  String? code;
  String? message;
  Data? data;

  CarDetailsModel({this.code, this.message, this.data});

  CarDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
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

  Data(
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
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    brandId = json['brand_id'].toString();
    model = json['model'];
    cylinder = json['cylinder'];
    mileage = json['mileage'];
    modelYear = json['model_year'];
    plateNumber = json['plate_number'];
    chasesNumber = json['chases_number'];
    fuelType = json['fuel_type'] ?? '';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'] ?? '';
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
    return data;
  }
}
