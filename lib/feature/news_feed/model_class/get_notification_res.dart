class GetNotificationsRes {
  NotificationData? data;

  GetNotificationsRes({this.data});

  GetNotificationsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new NotificationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NotificationData {
  List<Notifications>? notifications;

  NotificationData({this.notifications});

  NotificationData.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? id;
  String? title;
  String? type;
  String? body;
  Payload? payload;
  String? image;
  bool? markAsRead;
  dynamic readAt;
  String? dentalProfessionalId;
  String? createdAt;
  String? updatedAt;
  String? sTypename;

  Notifications(
      {this.id,
      this.title,
      this.type,
      this.body,
      this.payload,
      this.image,
      this.markAsRead,
      this.readAt,
      this.dentalProfessionalId,
      this.createdAt,
      this.updatedAt,
      this.sTypename});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    body = json['body'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
    image = json['image'];
    markAsRead = json['mark_as_read'];
    readAt = json['read_at'];
    dentalProfessionalId = json['dental_professional_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['body'] = this.body;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    data['image'] = this.image;
    data['mark_as_read'] = this.markAsRead;
    data['read_at'] = this.readAt;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Payload {
  String? id;

  Payload({this.id});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
