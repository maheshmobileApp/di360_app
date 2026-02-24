class GetSelfTalentEnquiries {
  Data? data;

  GetSelfTalentEnquiries({this.data});

  GetSelfTalentEnquiries.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<TalentEnquiries>? talentEnquiries;

  Data({this.talentEnquiries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['talent_enquiries'] != null) {
      talentEnquiries = <TalentEnquiries>[];
      json['talent_enquiries'].forEach((v) {
        talentEnquiries!.add(new TalentEnquiries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.talentEnquiries != null) {
      data['talent_enquiries'] =
          this.talentEnquiries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TalentEnquiries {
  String? id;
  String? talentId;
  String? createdAt;
  String? updatedAt;
  String? enqSenderId;
  String? enquiryDescription;
  String? sTypename;

  TalentEnquiries(
      {this.id,
      this.talentId,
      this.createdAt,
      this.updatedAt,
      this.enqSenderId,
      this.enquiryDescription,
      this.sTypename});

  TalentEnquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentId = json['talent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    enqSenderId = json['enq_sender_id'];
    enquiryDescription = json['enquiry_description'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talent_id'] = this.talentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['enq_sender_id'] = this.enqSenderId;
    data['enquiry_description'] = this.enquiryDescription;
    data['__typename'] = this.sTypename;
    return data;
  }
}
