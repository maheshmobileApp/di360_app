class GetPartnershipStatusRes {
  GetPartnershipStatusData? data;

  GetPartnershipStatusRes({this.data});

  GetPartnershipStatusRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetPartnershipStatusData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetPartnershipStatusData {
  List<PartnershipMembers>? partnershipMembers;

  GetPartnershipStatusData({this.partnershipMembers});

  GetPartnershipStatusData.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? type;
  String? sTypename;

  PartnershipMembers({this.status, this.type, this.sTypename});

  PartnershipMembers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['__typename'] = this.sTypename;
    return data;
  }
}
