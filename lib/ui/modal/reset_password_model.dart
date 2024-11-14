class ResetPasswordModel {
  String? code;
  String? message;
  Data? data;

  ResetPasswordModel({this.code, this.message, this.data});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
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
  String? role;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? mobileNumber;
  String? profile;
  String? otp;
  String? dob;
  String? gender;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;
  String? status;

  Data(
      {this.id,
      this.role,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.mobileNumber,
      this.profile,
      this.otp,
      this.dob,
      this.gender,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    role = json['role'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'].toString();
    mobileNumber = json['mobile_number'];
    profile = json['profile'].toString();
    otp = json['otp'];
    dob = json['dob'].toString();
    gender = json['gender'].toString();
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile_number'] = this.mobileNumber;
    data['profile'] = this.profile;
    data['otp'] = this.otp;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
