class ViewServiceModel {
  String? code;
  String? message;
  List<Data>? data;
  String? mainTotal;
  String? total75Percent;
  String? total25Percent;

  ViewServiceModel(
      {this.code,
      this.message,
      this.data,
      this.mainTotal,
      this.total25Percent,
      this.total75Percent});

  ViewServiceModel.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    mainTotal = json['main_total'].toString();
    total75Percent = json['main_total_75percent'] ?? '0.00';
    total25Percent = json['main_total_25percent'] ?? '0.00';
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
  String? serviceNumber;
  String? serviceName;
  String? serviceType;
  String? serviceDesc;
  String? qty;
  String? serviceCost;
  String? total;

  String? reportType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data({
    this.id,
    this.jobNumber,
    this.bookingId,
    this.status,
    this.serviceNumber,
    this.serviceType,
    this.serviceDesc,
    this.serviceName,
    this.qty,
    this.serviceCost,
    this.total,
    this.reportType,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    jobNumber = json['job_number'].toString();
    bookingId = json['booking_id'].toString();
    status = json['status'];
    serviceName = json['service_name'] ?? '';
    serviceNumber = json['service_number'];
    serviceType = json['service_type'];
    serviceDesc = json['service_desc'];
    qty = json['qty'];
    serviceCost = json['service_cost'];
    total = json['total'].toString();

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
    data['service_number'] = this.serviceNumber;
    data['service_type'] = this.serviceType;
    data['service_desc'] = this.serviceDesc;
    data['qty'] = this.qty;
    data['service_cost'] = this.serviceCost;
    data['total'] = this.total;
    data['report_type'] = this.reportType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
