class GetDirectoryRes {
  DirectoryData? data;

  GetDirectoryRes({this.data});

  GetDirectoryRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DirectoryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DirectoryData {
  List<Directories>? directories;

  DirectoryData({this.directories});

  DirectoryData.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? dentalSupplierId;
  String? communityId;
  String? partnershipLink;
  String? membershipLink;
  String? communityStatus;
  String? sTypename;

  Directories(
      {this.id,
      this.dentalSupplierId,
      this.communityId,
      this.partnershipLink,
      this.membershipLink,
      this.communityStatus,
      this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dentalSupplierId = json['dental_supplier_id'];
    communityId = json['community_id'];
    partnershipLink = json['partnership_link'];
    membershipLink = json['membership_link'];
    communityStatus = json['community_status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['community_id'] = this.communityId;
    data['partnership_link'] = this.partnershipLink;
    data['membership_link'] = this.membershipLink;
    data['community_status'] = this.communityStatus;
    data['__typename'] = this.sTypename;
    return data;
  }
}
