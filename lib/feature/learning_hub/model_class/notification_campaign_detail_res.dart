class NotificationCampaignDetailsRes {
  NotificationCampaignDetailsData? data;

  NotificationCampaignDetailsRes({this.data});

  NotificationCampaignDetailsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new NotificationCampaignDetailsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NotificationCampaignDetailsData {
  CourseNotificationCampaignsByPk? courseNotificationCampaignsByPk;

  NotificationCampaignDetailsData({this.courseNotificationCampaignsByPk});

  NotificationCampaignDetailsData.fromJson(Map<String, dynamic> json) {
    courseNotificationCampaignsByPk =
        json['course_notification_campaigns_by_pk'] != null
            ? new CourseNotificationCampaignsByPk.fromJson(
                json['course_notification_campaigns_by_pk'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseNotificationCampaignsByPk != null) {
      data['course_notification_campaigns_by_pk'] =
          this.courseNotificationCampaignsByPk!.toJson();
    }
    return data;
  }
}

class CourseNotificationCampaignsByPk {
  String? id;
  String? courseId;
  String? campaignName;
  String? notificationChannel;
  String? notificationType;
  String? templateType;
  String? emailSubject;
  String? messageBody;
  Null? attachments;
  String? recipientMode;
  Null? customRecipient;
  List<String>? recipientStatusFilter;
  String? sendMode;
  String? scheduledAt;
  int? totalRecipients;
  int? recipientsCount;
  String? status;
  Null? replyToEmail;
  String? createdAt;
  String? sTypename;

  CourseNotificationCampaignsByPk(
      {this.id,
      this.courseId,
      this.campaignName,
      this.notificationChannel,
      this.notificationType,
      this.templateType,
      this.emailSubject,
      this.messageBody,
      this.attachments,
      this.recipientMode,
      this.customRecipient,
      this.recipientStatusFilter,
      this.sendMode,
      this.scheduledAt,
      this.totalRecipients,
      this.recipientsCount,
      this.status,
      this.replyToEmail,
      this.createdAt,
      this.sTypename});

  CourseNotificationCampaignsByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    campaignName = json['campaign_name'];
    notificationChannel = json['notification_channel'];
    notificationType = json['notification_type'];
    templateType = json['template_type'];
    emailSubject = json['email_subject'];
    messageBody = json['message_body'];
    attachments = json['attachments'];
    recipientMode = json['recipient_mode'];
    customRecipient = json['custom_recipient'];
    recipientStatusFilter = json['recipient_status_filter'].cast<String>();
    sendMode = json['send_mode'];
    scheduledAt = json['scheduled_at'];
    totalRecipients = json['total_recipients'];
    recipientsCount = json['recipients_count'];
    status = json['status'];
    replyToEmail = json['reply_to_email'];
    createdAt = json['created_at'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['campaign_name'] = this.campaignName;
    data['notification_channel'] = this.notificationChannel;
    data['notification_type'] = this.notificationType;
    data['template_type'] = this.templateType;
    data['email_subject'] = this.emailSubject;
    data['message_body'] = this.messageBody;
    data['attachments'] = this.attachments;
    data['recipient_mode'] = this.recipientMode;
    data['custom_recipient'] = this.customRecipient;
    data['recipient_status_filter'] = this.recipientStatusFilter;
    data['send_mode'] = this.sendMode;
    data['scheduled_at'] = this.scheduledAt;
    data['total_recipients'] = this.totalRecipients;
    data['recipients_count'] = this.recipientsCount;
    data['status'] = this.status;
    data['reply_to_email'] = this.replyToEmail;
    data['created_at'] = this.createdAt;
    data['__typename'] = this.sTypename;
    return data;
  }
}
