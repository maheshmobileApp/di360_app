class GetPartnershipMembers {
  PartnershipMembersData? data;

  GetPartnershipMembers({this.data});

  GetPartnershipMembers.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PartnershipMembersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PartnershipMembersData {
  List<PartnershipMembers>? partnershipMembers;

  PartnershipMembersData({this.partnershipMembers});

  PartnershipMembersData.fromJson(Map<String, dynamic> json) {
    if (json['partnership_members'] != null) {
      partnershipMembers = <PartnershipMembers>[];
      json['partnership_members'].forEach((v) {
        partnershipMembers!.add(new PartnershipMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.partnershipMembers != null) {
      data['partnership_members'] =
          this.partnershipMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartnershipMembers {
  String? id;
  String? companyName;
  String? contactName;
  String? email;
  String? phone;
  String? status;
  bool? isRegistered;
  String? communityId;
  String? supplierId;
  Null? registerLink;
  String? sTypename;

  PartnershipMembers(
      {this.id,
      this.companyName,
      this.contactName,
      this.email,
      this.phone,
      this.status,
      this.isRegistered,
      this.communityId,
      this.supplierId,
      this.registerLink,
      this.sTypename});

  PartnershipMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    contactName = json['contact_name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    isRegistered = json['is_registered'];
    communityId = json['community_id'];
    supplierId = json['supplier_id'];
    registerLink = json['register_link'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['contact_name'] = this.contactName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['is_registered'] = this.isRegistered;
    data['community_id'] = this.communityId;
    data['supplier_id'] = this.supplierId;
    data['register_link'] = this.registerLink;
    data['__typename'] = this.sTypename;
    return data;
  }
}
