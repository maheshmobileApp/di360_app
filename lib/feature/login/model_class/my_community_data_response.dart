class MyCommunityDataReponse {
  CommunityData? data;

  MyCommunityDataReponse({this.data});

  MyCommunityDataReponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CommunityData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommunityData {
  List<CommunityMembers>? communityMembers;

  CommunityData({this.communityMembers});

  CommunityData.fromJson(Map<String, dynamic> json) {
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
  String? communityName;
  String? communityId;
  String? sTypename;

  CommunityMembers(
      {this.id, this.communityName, this.communityId, this.sTypename});

  CommunityMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    communityName = json['community_name'];
    communityId = json['community_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['community_name'] = this.communityName;
    data['community_id'] = this.communityId;
    data['__typename'] = this.sTypename;
    return data;
  }
}
