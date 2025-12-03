class GetCommunityStatusRes {
  CommunityStatusData? data;

  GetCommunityStatusRes({this.data});

  GetCommunityStatusRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CommunityStatusData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommunityStatusData {
  List<CommunityMembers>? communityMembers;

  CommunityStatusData({this.communityMembers});

  CommunityStatusData.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? sTypename;

  CommunityMembers({this.status, this.sTypename});

  CommunityMembers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['__typename'] = this.sTypename;
    return data;
  }
}