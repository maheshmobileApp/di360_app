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
  String? firstName;
  String? lastName;
  String? membershipNumber;
  String? status;
  String? email;
  String? phone;
  String? supplierId;
  String? communityId;
  Null? registerLink;
  bool? isRegistered;
  String? sTypename;

  PartnershipMembers(
      {this.id,
      this.firstName,
      this.lastName,
      this.membershipNumber,
      this.status,
      this.email,
      this.phone,
      this.supplierId,
      this.communityId,
      this.registerLink,
      this.isRegistered,
      this.sTypename});

  PartnershipMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    membershipNumber = json['membership_number'];
    status = json['status'];
    email = json['email'];
    phone = json['phone'];
    supplierId = json['supplier_id'];
    communityId = json['community_id'];
    registerLink = json['register_link'];
    isRegistered = json['is_registered'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['membership_number'] = this.membershipNumber;
    data['status'] = this.status;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['supplier_id'] = this.supplierId;
    data['community_id'] = this.communityId;
    data['register_link'] = this.registerLink;
    data['is_registered'] = this.isRegistered;
    data['__typename'] = this.sTypename;
    return data;
  }
}
