class GetCommunityMembersRes {
  CommunityMembersData? data;

  GetCommunityMembersRes({this.data});

  GetCommunityMembersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CommunityMembersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommunityMembersData {
  List<CommunityMembers>? communityMembers;

  CommunityMembersData({this.communityMembers});

  CommunityMembersData.fromJson(Map<String, dynamic> json) {
    if (json['community_members'] != null) {
      communityMembers = <CommunityMembers>[];
      json['community_members'].forEach((v) {
        communityMembers!.add(new CommunityMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.communityMembers != null) {
      data['community_members'] =
          this.communityMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommunityMembers {
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

  CommunityMembers(
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

  CommunityMembers.fromJson(Map<String, dynamic> json) {
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
