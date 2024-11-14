class ViewPartsModel {
  String? code;
  String? message;
  List<Data>? data;
  String? mainTotal;

  ViewPartsModel({this.code, this.message, this.data, this.mainTotal});

  ViewPartsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    mainTotal = json['main_total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['main_total'] = this.mainTotal;
    return data;
  }
}

class Data {
  String? id;
  String? jobNumber;
  String? bookingId;
  String? status;
  String? partNumber;
  String? partType;
  String? partDesc;
  String? qty;
  String? estCost;
  String? total;
  String? reportType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
      this.jobNumber,
      this.bookingId,
      this.status,
      this.partNumber,
      this.partType,
      this.partDesc,
      this.qty,
      this.estCost,
      this.total,
      this.reportType,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    jobNumber = json['job_number'].toString();
    bookingId = json['booking_id'].toString();
    status = json['status'];
    partNumber = json['part_number'];
    partType = json['part_type'];
    partDesc = json['part_desc'];
    qty = json['qty'];
    estCost = json['est_cost'];
    total = json['total'];
    reportType = json['report_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_number'] = this.jobNumber;
    data['booking_id'] = this.bookingId;
    data['status'] = this.status;
    data['part_number'] = this.partNumber;
    data['part_type'] = this.partType;
    data['part_desc'] = this.partDesc;
    data['qty'] = this.qty;
    data['est_cost'] = this.estCost;
    data['total'] = this.total;
    data['report_type'] = this.reportType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
