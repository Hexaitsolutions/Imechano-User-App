class Data1 {
  String? id;
  String? categoryId;
  String? name;
  int? counter;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<bool>? selected;
  Map? selectedService;

  Data1(
      {this.id,
      this.categoryId,
      this.name,
      this.counter,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.selected,
      this.selectedService});

  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    categoryId = json['category_id'].toString();
    name = json['name'];
    counter = 0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
    selected = List.generate(10, (i) => false);
    selectedService = {};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['counter'] = this.counter;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
