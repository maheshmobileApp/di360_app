class GetCampaignListingRes {
  CampaignListData? data;

  GetCampaignListingRes({this.data});

  GetCampaignListingRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CampaignListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CampaignListData {
  List<SmsCampaign>? smsCampaign;
  Sent? smsCampaignAggregate;

  CampaignListData({this.smsCampaign, this.smsCampaignAggregate});

  CampaignListData.fromJson(Map<String, dynamic> json) {
    if (json['sms_campaign'] != null) {
      smsCampaign = <SmsCampaign>[];
      json['sms_campaign'].forEach((v) {
        smsCampaign!.add(SmsCampaign.fromJson(v));
      });
    }
    smsCampaignAggregate = json['sms_campaign_aggregate'] != null
        ? Sent.fromJson(json['sms_campaign_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.smsCampaign != null) {
      data['sms_campaign'] = this.smsCampaign!.map((v) => v.toJson()).toList();
    }
    if (this.smsCampaignAggregate != null) {
      data['sms_campaign_aggregate'] = this.smsCampaignAggregate!.toJson();
    }
    return data;
  }
}

class SmsCampaign {
  String? id;
  String? campaignName;
  String? messageChannel;
  String? fromEmail;
  String? messageText;
  List<dynamic>? emailAttachments;
  String? scheduleDate;
  String? scheduleTimeLocal;
  String? isRepeating;
  String? status;
  String? createdAt;
  Sent? sent;
  Sent? failed;
  Sent? queued;
  String? sTypename;

  SmsCampaign(
      {this.id,
      this.campaignName,
      this.messageChannel,
      this.fromEmail,
      this.messageText,
      this.emailAttachments,
      this.scheduleDate,
      this.scheduleTimeLocal,
      this.isRepeating,
      this.status,
      this.createdAt,
      this.sent,
      this.failed,
      this.queued,
      this.sTypename});

  SmsCampaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignName = json['campaign_name'];
    messageChannel = json['message_channel'];
    fromEmail = json['from_email'];
    messageText = json['message_text'];
    if (json['email_attachments'] != null) {
      emailAttachments = json['email_attachments'];
    }
    scheduleDate = json['schedule_date'];
    scheduleTimeLocal = json['schedule_time_local'];
    isRepeating = json['is_repeating'];
    status = json['status'];
    createdAt = json['created_at'];
    sent = json['sent'] != null ? Sent.fromJson(json['sent']) : null;
    failed = json['failed'] != null ? Sent.fromJson(json['failed']) : null;
    queued = json['queued'] != null ? Sent.fromJson(json['queued']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['campaign_name'] = this.campaignName;
    data['message_channel'] = this.messageChannel;
    data['from_email'] = this.fromEmail;
    data['message_text'] = this.messageText;
    if (this.emailAttachments != null) {
      data['email_attachments'] = this.emailAttachments;
    }
    data['schedule_date'] = this.scheduleDate;
    data['schedule_time_local'] = this.scheduleTimeLocal;
    data['is_repeating'] = this.isRepeating;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.sent != null) {
      data['sent'] = this.sent!.toJson();
    }
    if (this.failed != null) {
      data['failed'] = this.failed!.toJson();
    }
    if (this.queued != null) {
      data['queued'] = this.queued!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Sent {
  Aggregate? aggregate;
  String? sTypename;

  Sent({this.aggregate, this.sTypename});

  Sent.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;
    return data;
  }
}
