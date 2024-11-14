class BrandModelList {
  String? code;
  String? message;
  List<Data>? data;

  BrandModelList({this.code, this.message, this.data});

  BrandModelList.fromJson(Map<String, dynamic> json) {
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
  String? brandId;
  String? model;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? image;

  Data(
      {this.id,
      this.brandId,
      this.model,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    brandId = json['brand_id'].toString();
    model = json['model'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_id'] = this.brandId;
    data['model'] = this.model;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['image'] = this.image;
    return data;
  }
}
