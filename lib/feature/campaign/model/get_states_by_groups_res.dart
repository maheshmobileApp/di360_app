class GetStatesByGroupsRes {
  StatesByGroupsData? data;

  GetStatesByGroupsRes({this.data});

  GetStatesByGroupsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? StatesByGroupsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class StatesByGroupsData {
  List<CampaignContacts>? campaignContacts;

  StatesByGroupsData({this.campaignContacts});

  StatesByGroupsData.fromJson(Map<String, dynamic> json) {
    if (json['campaign_contacts'] != null) {
      campaignContacts = <CampaignContacts>[];
      json['campaign_contacts'].forEach((v) {
        campaignContacts!.add(CampaignContacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.campaignContacts != null) {
      data['campaign_contacts'] =
          this.campaignContacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CampaignContacts {
  String? state;
  String? sTypename;

  CampaignContacts({this.state, this.sTypename});

  CampaignContacts.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['__typename'] = this.sTypename;
    return data;
  }
}
