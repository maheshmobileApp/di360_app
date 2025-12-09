class GetSupportRequestRes {
  SupportRequestsData? data;

  GetSupportRequestRes({this.data});

  GetSupportRequestRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupportRequestsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupportRequestsData {
  List<SupportRequests>? supportRequests;

  SupportRequestsData({this.supportRequests});

  SupportRequestsData.fromJson(Map<String, dynamic> json) {
    if (json['support_requests'] != null) {
      supportRequests = <SupportRequests>[];
      json['support_requests'].forEach((v) {
        supportRequests!.add(new SupportRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supportRequests != null) {
      data['support_requests'] =
          this.supportRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportRequests {
  String? id;
  String? createdAt;
  String? updatedAt;
  Null? suppliesOrderId;
  Null? suppliesOrder;
  Null? secondHandSuppliesOrderId;
  Null? secondHandSuppliesOrder;
  String? reason;
  String? message;
  Null? attachments;
  String? status;
  Null? reply;
  Null? replyAttachments;
  int? supportRequestNumber;
  String? type;
  Null? dentalPractice;
  DentalSupplier? dentalSupplier;
  Null? dentalProfessional;
  String? sTypename;

  SupportRequests(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.suppliesOrderId,
      this.suppliesOrder,
      this.secondHandSuppliesOrderId,
      this.secondHandSuppliesOrder,
      this.reason,
      this.message,
      this.attachments,
      this.status,
      this.reply,
      this.replyAttachments,
      this.supportRequestNumber,
      this.type,
      this.dentalPractice,
      this.dentalSupplier,
      this.dentalProfessional,
      this.sTypename});

  SupportRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    suppliesOrderId = json['supplies_order_id'];
    suppliesOrder = json['supplies_order'];
    secondHandSuppliesOrderId = json['second_hand_supplies_order_id'];
    secondHandSuppliesOrder = json['second_hand_supplies_order'];
    reason = json['reason'];
    message = json['message'];
    attachments = json['attachments'];
    status = json['status'];
    reply = json['reply'];
    replyAttachments = json['reply_attachments'];
    supportRequestNumber = json['support_request_number'];
    type = json['type'];
    dentalPractice = json['dental_practice'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalProfessional = json['dental_professional'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['supplies_order_id'] = this.suppliesOrderId;
    data['supplies_order'] = this.suppliesOrder;
    data['second_hand_supplies_order_id'] = this.secondHandSuppliesOrderId;
    data['second_hand_supplies_order'] = this.secondHandSuppliesOrder;
    data['reason'] = this.reason;
    data['message'] = this.message;
    data['attachments'] = this.attachments;
    data['status'] = this.status;
    data['reply'] = this.reply;
    data['reply_attachments'] = this.replyAttachments;
    data['support_request_number'] = this.supportRequestNumber;
    data['type'] = this.type;
    data['dental_practice'] = this.dentalPractice;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['dental_professional'] = this.dentalProfessional;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplier {
  String? type;
  String? businessName;
  String? email;
  Logo? logo;
  String? sTypename;

  DentalSupplier(
      {this.type, this.businessName, this.email, this.logo, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    businessName = json['business_name'];
    email = json['email'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['business_name'] = this.businessName;
    data['email'] = this.email;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Logo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Logo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Logo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    status = json['status'];
    fileId = json['file_id'];
    isPublic = json['isPublic'];
    directory = json['directory'];
    extension = json['extension'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['status'] = this.status;
    data['file_id'] = this.fileId;
    data['isPublic'] = this.isPublic;
    data['directory'] = this.directory;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
    return data;
  }
}
