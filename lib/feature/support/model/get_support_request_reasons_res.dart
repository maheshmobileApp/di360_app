class GetSupportRequestReasonsRes {
  GetSupportRequestReasonData? data;

  GetSupportRequestReasonsRes({this.data});

  GetSupportRequestReasonsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetSupportRequestReasonData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetSupportRequestReasonData {
  List<SupportRequestReasons>? supportRequestReasons;

  GetSupportRequestReasonData({this.supportRequestReasons});

  GetSupportRequestReasonData.fromJson(Map<String, dynamic> json) {
    if (json['support_request_reasons'] != null) {
      supportRequestReasons = <SupportRequestReasons>[];
      json['support_request_reasons'].forEach((v) {
        supportRequestReasons!.add(new SupportRequestReasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supportRequestReasons != null) {
      data['support_request_reasons'] =
          this.supportRequestReasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportRequestReasons {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? sTypename;

  SupportRequestReasons(
      {this.id, this.createdAt, this.updatedAt, this.name, this.sTypename});

  SupportRequestReasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}
