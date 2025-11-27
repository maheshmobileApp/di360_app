class GetJoinedCommunityMembersRes {
  GetJoinedCommunityMembersData? data;

  GetJoinedCommunityMembersRes({this.data});

  GetJoinedCommunityMembersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetJoinedCommunityMembersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetJoinedCommunityMembersData {
  List<CommunityMembers>? communityMembers;

  GetJoinedCommunityMembersData({this.communityMembers});

  GetJoinedCommunityMembersData.fromJson(Map<String, dynamic> json) {
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
  String? communityId;
  String? communityName;
  String? supplierId;
  String? memberId;
  String? status;
  String? sTypename;

  CommunityMembers(
      {this.id,
      this.communityId,
      this.communityName,
      this.supplierId,
      this.memberId,
      this.status,
      this.sTypename});

  CommunityMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    communityId = json['community_id'];
    communityName = json['community_name'];
    supplierId = json['supplier_id'];
    memberId = json['member_id'];
    status = json['status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['community_id'] = this.communityId;
    data['community_name'] = this.communityName;
    data['supplier_id'] = this.supplierId;
    data['member_id'] = this.memberId;
    data['status'] = this.status;
    data['__typename'] = this.sTypename;
    return data;
  }
}
