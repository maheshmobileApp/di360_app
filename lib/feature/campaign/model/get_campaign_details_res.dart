class GetCampaignDetailsRes {
  CampaignDetailsData? data;

  GetCampaignDetailsRes({this.data});

  GetCampaignDetailsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CampaignDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CampaignDetailsData {
  SmsCampaignByPk? smsCampaignByPk;

  CampaignDetailsData({this.smsCampaignByPk});

  CampaignDetailsData.fromJson(Map<String, dynamic> json) {
    smsCampaignByPk = json['sms_campaign_by_pk'] != null
        ? SmsCampaignByPk.fromJson(json['sms_campaign_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.smsCampaignByPk != null) {
      data['sms_campaign_by_pk'] = this.smsCampaignByPk!.toJson();
    }
    return data;
  }
}

class SmsCampaignByPk {
  String? campaignName;
  String? scheduleDate;
  String? scheduleTimeLocal;
  String? scheduleTimezone;
  int? recipientsCount;
  int? mobileEmailCount;
  int? totalCount;
  String? messageText;
  int? smsSegmentsCount;
  int? charactersUsed;
  String? isRepeating;
  String? isRefinedByState;
  List<dynamic>? refineState;
  List<String>? groups;
  List<String>? sendToNumbers;
  String? status;
  dynamic sendToEmails;
  String? emailSubject;
  String? messageChannel;
  List<dynamic>? emailAttachments;
  dynamic fromEmail;
  dynamic emailDesignJson;
  String? sTypename;

  SmsCampaignByPk(
      {this.campaignName,
      this.scheduleDate,
      this.scheduleTimeLocal,
      this.scheduleTimezone,
      this.recipientsCount,
      this.mobileEmailCount,
      this.totalCount,
      this.messageText,
      this.smsSegmentsCount,
      this.charactersUsed,
      this.isRepeating,
      this.isRefinedByState,
      this.refineState,
      this.groups,
      this.sendToNumbers,
      this.status,
      this.sendToEmails,
      this.emailSubject,
      this.messageChannel,
      this.emailAttachments,
      this.fromEmail,
      this.emailDesignJson,
      this.sTypename});

  SmsCampaignByPk.fromJson(Map<String, dynamic> json) {
    campaignName = json['campaign_name'];
    scheduleDate = json['schedule_date'];
    scheduleTimeLocal = json['schedule_time_local'];
    scheduleTimezone = json['schedule_timezone'];
    recipientsCount = json['recipients_count'];
    mobileEmailCount = json['mobile_email_count'];
    totalCount = json['total_count'];
    messageText = json['message_text'];
    smsSegmentsCount = json['sms_segments_count'];
    charactersUsed = json['characters_used'];
    isRepeating = json['is_repeating'];
    isRefinedByState = json['is_refined_by_state'];
    if (json['refine_state'] != null) {
      refineState = json['refine_state'];
    }
    groups = json['groups']?.cast<String>();
    sendToNumbers = json['send_to_numbers']?.cast<String>();
    status = json['status'];
    sendToEmails = json['send_to_emails'];
    emailSubject = json['email_subject'];
    messageChannel = json['message_channel'];
    if (json['email_attachments'] != null) {
      emailAttachments = json['email_attachments'];
    }
    fromEmail = json['from_email'];
    emailDesignJson = json['email_design_json'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_name'] = this.campaignName;
    data['schedule_date'] = this.scheduleDate;
    data['schedule_time_local'] = this.scheduleTimeLocal;
    data['schedule_timezone'] = this.scheduleTimezone;
    data['recipients_count'] = this.recipientsCount;
    data['mobile_email_count'] = this.mobileEmailCount;
    data['total_count'] = this.totalCount;
    data['message_text'] = this.messageText;
    data['sms_segments_count'] = this.smsSegmentsCount;
    data['characters_used'] = this.charactersUsed;
    data['is_repeating'] = this.isRepeating;
    data['is_refined_by_state'] = this.isRefinedByState;
    if (this.refineState != null) {
      data['refine_state'] = this.refineState;
    }
    data['groups'] = this.groups;
    data['send_to_numbers'] = this.sendToNumbers;
    data['status'] = this.status;
    data['send_to_emails'] = this.sendToEmails;
    data['email_subject'] = this.emailSubject;
    data['message_channel'] = this.messageChannel;
    if (this.emailAttachments != null) {
      data['email_attachments'] = this.emailAttachments;
    }
    data['from_email'] = this.fromEmail;
    data['email_design_json'] = this.emailDesignJson;
    data['__typename'] = this.sTypename;
    return data;
  }
}
