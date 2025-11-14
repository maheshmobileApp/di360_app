class TalentsMessageRes {
  TalentsMessageResData? data;

  TalentsMessageRes({this.data});

  TalentsMessageRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TalentsMessageResData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentsMessageResData {
  List<TalentsMessage>? talentsMessage;

  TalentsMessageResData({this.talentsMessage});

  TalentsMessageResData.fromJson(Map<String, dynamic> json) {
    if (json['talents_message'] != null) {
      talentsMessage = <TalentsMessage>[];
      json['talents_message'].forEach((v) {
        talentsMessage!.add(new TalentsMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.talentsMessage != null) {
      data['talents_message'] =
          this.talentsMessage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TalentsMessage {
  String? id;
  String? createdAt;
  String? message;
  String? messageFrom;
  Null? attachments;

  TalentsMessage(
      {this.id,
      this.createdAt,
      this.message,
      this.messageFrom,
      this.attachments});

  TalentsMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    message = json['message'];
    messageFrom = json['message_from'];
    attachments = json['attachments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['message'] = this.message;
    data['message_from'] = this.messageFrom;
    data['attachments'] = this.attachments;
    return data;
  }
}
