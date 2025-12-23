class GetTalentEnquiryRes {
  TalentEnquiriesData? data;

  GetTalentEnquiryRes({this.data});

  GetTalentEnquiryRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TalentEnquiriesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentEnquiriesData {
  List<TalentEnquiries>? talentEnquiries;

  TalentEnquiriesData({this.talentEnquiries});

  TalentEnquiriesData.fromJson(Map<String, dynamic> json) {
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
  String? enquiryFrom;
  String? enquiryDescription;
  String? sTypename;

  TalentEnquiries(
      {this.id,
      this.talentId,
      this.createdAt,
      this.updatedAt,
      this.enquiryFrom,
      this.enquiryDescription,
      this.sTypename});

  TalentEnquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentId = json['talent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    enquiryFrom = json['enquiry_from'];
    enquiryDescription = json['enquiry_description'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talent_id'] = this.talentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['enquiry_from'] = this.enquiryFrom;
    data['enquiry_description'] = this.enquiryDescription;
    data['__typename'] = this.sTypename;
    return data;
  }
}
