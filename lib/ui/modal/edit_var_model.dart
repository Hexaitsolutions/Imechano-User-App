class Editecarliatmodel {
  String? code;
  String? message;
  Data? data;
  Editecarliatmodel({this.code, this.message, this.data});
  Editecarliatmodel.fromJson(Map<String, dynamic> json) {
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
  String? model;
  String? cylinder;
  String? mileage;
  String? modelYear;
  String? plateNumber;
  String? chasesNumber;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Data(
      {this.id,
      this.userId,
      this.model,
      this.cylinder,
      this.mileage,
      this.modelYear,
      this.plateNumber,
      this.chasesNumber,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    model = json['model'];
    cylinder = json['cylinder'];
    mileage = json['mileage'];
    modelYear = json['model_year'];
    plateNumber = json['plate_number'];
    chasesNumber = json['chases_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['model'] = this.model;
    data['cylinder'] = this.cylinder;
    data['mileage'] = this.mileage;
    data['model_year'] = this.modelYear;
    data['plate_number'] = this.plateNumber;
    data['chases_number'] = this.chasesNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
