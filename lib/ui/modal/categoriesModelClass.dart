

class CategoriesModelClass {
  String? code;
  String? message;
  List<Data>? data;
  //List<Data1>? subdata;

  CategoriesModelClass({this.code, this.message, this.data});

  CategoriesModelClass.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    // if (json['subdata'] != null) {
    //   subdata = <Data1>[];
    //   json['subdata'].forEach((v) {
    //     subdata!.add(new Data1.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    // if (this.subdata != null) {
    //   data['subdata'] = this.subdata!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Data {
  String? id;
  String? icon;
  String? categoryName;
  String? subcategory_Name;
  String? item_name;
  String? item_id;
  String? subcategory_id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
      this.icon,
      this.categoryName,
      this.subcategory_Name,
      this.subcategory_id,
      this.item_id,
      this.item_name,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    icon = json['icon'];
    categoryName = json['category_name'];
    subcategory_Name = json['subcategory_name'];
    subcategory_id = json['subcategory_id'].toString();
    item_id = json['item_id'].toString();
    item_name = json['item_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['category_name'] = this.categoryName;
    data['subcategory_name'] = this.subcategory_Name;
    data['subcategory_id'] = this.subcategory_id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;

    return data;
  }
}
