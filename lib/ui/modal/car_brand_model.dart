class CarBrandModel {
  String? code;
  String? message;
  List<CarBrandData>? data;

  CarBrandModel({this.code, this.message, this.data});

  CarBrandModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <CarBrandData>[];
      json['data'].forEach((v) {
        data!.add(new CarBrandData.fromJson(v));
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

class CarBrandData {
  String? id;
  String? logo;
  String? brand;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CarBrandData(
      {this.id,
      this.logo,
      this.brand,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CarBrandData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    logo = json['logo'].toString();
    brand = json['brand'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['brand'] = this.brand;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
