class ApproveJobCardModel {
  String? code;
  String? message;

  ApproveJobCardModel({this.code, this.message});

  ApproveJobCardModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
