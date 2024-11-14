class ItemListModel {
  String? code;
  String? message;
  List<ItemListData>? data;

  ItemListModel({this.code, this.message, this.data});

  ItemListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <ItemListData>[];
      json['data'].forEach((v) {
        data!.add(new ItemListData.fromJson(v));
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

class ItemListData {
  String? id;
  String? subCategoryId;
  String? item;
  String? price;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? isCheck;

  ItemListData(
      {this.id,
      this.subCategoryId,
      this.item,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isCheck});

  ItemListData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    subCategoryId = json['sub_category_id'].toString();
    item = json['item'];
    price = json['price'] ?? '';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
    isCheck = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_id'] = this.subCategoryId;
    data['item'] = this.item;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
