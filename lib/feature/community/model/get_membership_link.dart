class GetMembershipLink {
  MembershipLinkData? data;

  GetMembershipLink({this.data});

  GetMembershipLink.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new MembershipLinkData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MembershipLinkData {
  List<Directories>? directories;

  MembershipLinkData({this.directories});

  MembershipLinkData.fromJson(Map<String, dynamic> json) {
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Directories {
  String? membershipLink;
  String? sTypename;

  Directories({this.membershipLink, this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    membershipLink = json['membership_link'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_link'] = this.membershipLink;
    data['__typename'] = this.sTypename;
    return data;
  }
}
