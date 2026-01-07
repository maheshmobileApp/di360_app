class GetContactCountRes {
  ContactCountData? data;

  GetContactCountRes({this.data});

  GetContactCountRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ContactCountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ContactCountData {
  CampaignContactsAggregate? campaignContactsAggregate;

  ContactCountData({this.campaignContactsAggregate});

  ContactCountData.fromJson(Map<String, dynamic> json) {
    campaignContactsAggregate = json['campaign_contacts_aggregate'] != null
        ? CampaignContactsAggregate.fromJson(
            json['campaign_contacts_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (campaignContactsAggregate != null) {
      data['campaign_contacts_aggregate'] =
          campaignContactsAggregate!.toJson();
    }
    return data;
  }
}

class CampaignContactsAggregate {
  Aggregate? aggregate;
  String? sTypename;

  CampaignContactsAggregate({this.aggregate, this.sTypename});

  CampaignContactsAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (aggregate != null) {
      data['aggregate'] = aggregate!.toJson();
    }
    data['__typename'] = sTypename;
    return data;
  }
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate({this.count, this.sTypename});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['__typename'] = sTypename;
    return data;
  }
}
