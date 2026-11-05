class GetNotificationCampaignRes {
  NotificationCampaignData? data;

  GetNotificationCampaignRes({this.data});

  GetNotificationCampaignRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new NotificationCampaignData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NotificationCampaignData {
  List<CourseNotificationCampaigns>? courseNotificationCampaigns;
  CourseNotificationCampaignsAggregate? courseNotificationCampaignsAggregate;

  NotificationCampaignData(
      {this.courseNotificationCampaigns,
      this.courseNotificationCampaignsAggregate});

  NotificationCampaignData.fromJson(Map<String, dynamic> json) {
    if (json['course_notification_campaigns'] != null) {
      courseNotificationCampaigns = <CourseNotificationCampaigns>[];
      json['course_notification_campaigns'].forEach((v) {
        courseNotificationCampaigns!
            .add(new CourseNotificationCampaigns.fromJson(v));
      });
    }
    courseNotificationCampaignsAggregate =
        json['course_notification_campaigns_aggregate'] != null
            ? new CourseNotificationCampaignsAggregate.fromJson(
                json['course_notification_campaigns_aggregate'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseNotificationCampaigns != null) {
      data['course_notification_campaigns'] =
          this.courseNotificationCampaigns!.map((v) => v.toJson()).toList();
    }
    if (this.courseNotificationCampaignsAggregate != null) {
      data['course_notification_campaigns_aggregate'] =
          this.courseNotificationCampaignsAggregate!.toJson();
    }
    return data;
  }
}

class CourseNotificationCampaigns {
  String? id;
  String? campaignName;
  String? notificationChannel;
  String? emailSubject;
  String? recipientMode;
  String? sendMode;
  String? scheduledAt;
  int? totalRecipients;
  int? recipientsCount;
  String? status;
  String? createdAt;
  String? notificationType;
  String? sTypename;

  CourseNotificationCampaigns(
      {this.id,
      this.campaignName,
      this.notificationChannel,
      this.emailSubject,
      this.recipientMode,
      this.sendMode,
      this.scheduledAt,
      this.totalRecipients,
      this.recipientsCount,
      this.status,
      this.createdAt,
      this.notificationType,
      this.sTypename});

  CourseNotificationCampaigns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignName = json['campaign_name'];
    notificationChannel = json['notification_channel'];
    emailSubject = json['email_subject'];
    recipientMode = json['recipient_mode'];
    sendMode = json['send_mode'];
    scheduledAt = json['scheduled_at'];
    totalRecipients = json['total_recipients'];
    recipientsCount = json['recipients_count'];
    status = json['status'];
    createdAt = json['created_at'];
    notificationType = json['notification_type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['campaign_name'] = this.campaignName;
    data['notification_channel'] = this.notificationChannel;
    data['email_subject'] = this.emailSubject;
    data['recipient_mode'] = this.recipientMode;
    data['send_mode'] = this.sendMode;
    data['scheduled_at'] = this.scheduledAt;
    data['total_recipients'] = this.totalRecipients;
    data['recipients_count'] = this.recipientsCount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['notification_type'] = this.notificationType;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CourseNotificationCampaignsAggregate {
  Aggregate? aggregate;
  String? sTypename;

  CourseNotificationCampaignsAggregate({this.aggregate, this.sTypename});

  CourseNotificationCampaignsAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
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
