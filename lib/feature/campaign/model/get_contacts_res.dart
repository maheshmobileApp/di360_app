class GetContactsRes {
  ContactsData? data;

  GetContactsRes({this.data});

  GetContactsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ContactsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ContactsData {
  List<CampaignContacts>? campaignContacts;

  ContactsData({this.campaignContacts});

  ContactsData.fromJson(Map<String, dynamic> json) {
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
  String? phone;
  String? email;
  String? sTypename;

  CampaignContacts({this.phone, this.email, this.sTypename});

  CampaignContacts.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['__typename'] = this.sTypename;
    return data;
  }
}
