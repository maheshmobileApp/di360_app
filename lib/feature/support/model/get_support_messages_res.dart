class GetSupportMessageRes {
  SupportMessagesData? data;

  GetSupportMessageRes({this.data});

  GetSupportMessageRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupportMessagesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupportMessagesData {
  List<SupportRequestsConversations>? supportRequestsConversations;

  SupportMessagesData({this.supportRequestsConversations});

  SupportMessagesData.fromJson(Map<String, dynamic> json) {
    if (json['support_requests_conversations'] != null) {
      supportRequestsConversations = <SupportRequestsConversations>[];
      json['support_requests_conversations'].forEach((v) {
        supportRequestsConversations!
            .add(new SupportRequestsConversations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supportRequestsConversations != null) {
      data['support_requests_conversations'] =
          this.supportRequestsConversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportRequestsConversations {
  String? id;
  String? message;
  String? senderId;
  String? senderType;
  String? createdAt;
  String? updatedAt;
  List<Attachments>? attachments;
  String? supportRequestId;

  SupportRequestsConversations(
      {this.id,
      this.message,
      this.senderId,
      this.senderType,
      this.createdAt,
      this.updatedAt,
      this.attachments,
      this.supportRequestId});

  SupportRequestsConversations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    senderId = json['sender_id'];
    senderType = json['sender_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    supportRequestId = json['support_request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['sender_id'] = this.senderId;
    data['sender_type'] = this.senderType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    data['support_request_id'] = this.supportRequestId;
    return data;
  }
}

class Attachments {
  String? url;
  String? name;
  String? type;
  String? extension;

  Attachments({this.url, this.name, this.type, this.extension});

  Attachments.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    type = json['type'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['extension'] = this.extension;
    return data;
  }
}
