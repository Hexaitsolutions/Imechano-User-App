// ignore: camel_case_types
class addCarModel {
  String? code;
  String? message;
  Data? data;

  addCarModel({this.code, this.message, this.data});

  addCarModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? model;
  String? cylinder;
  String? mileage;
  String? modelYear;
  String? plateNumber;
  String? chasesNumber;
  String? updatedAt;
  String? createdAt;
  String? id;

  Data(
      {this.userId,
      this.model,
      this.cylinder,
      this.mileage,
      this.modelYear,
      this.plateNumber,
      this.chasesNumber,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'].toString();
    model = json['model'];
    cylinder = json['cylinder'];
    mileage = json['mileage'];
    modelYear = json['model_year'];
    plateNumber = json['plate_number'];
    chasesNumber = json['chases_number'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['model'] = this.model;
    data['cylinder'] = this.cylinder;
    data['mileage'] = this.mileage;
    data['model_year'] = this.modelYear;
    data['plate_number'] = this.plateNumber;
    data['chases_number'] = this.chasesNumber;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
