class GetEnquiriesMessagesRes {
  EnquiriesMessagesData? data;

  GetEnquiriesMessagesRes({this.data});

  GetEnquiriesMessagesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new EnquiriesMessagesData.fromJson(json['data'])
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

class EnquiriesMessagesData {
  List<JobApplicantMessages>? jobApplicantMessages;

  EnquiriesMessagesData({this.jobApplicantMessages});

  EnquiriesMessagesData.fromJson(Map<String, dynamic> json) {
    if (json['job_applicant_messages'] != null) {
      jobApplicantMessages = <JobApplicantMessages>[];
      json['job_applicant_messages'].forEach((v) {
        jobApplicantMessages!.add(new JobApplicantMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobApplicantMessages != null) {
      data['job_applicant_messages'] =
          this.jobApplicantMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobApplicantMessages {
  String? id;
  String? jobEnquiryId;
  String? message;
  String? messageFrom;
  Null attachments;
  String? jobApplicantId;
  String? createdAt;
  String? updatedAt;
  bool? deletedStatus;
  String? senderId;
  String? receiverId;
  String? senderType;
  String? receiverType;
  String? sTypename;

  JobApplicantMessages(
      {this.id,
      this.jobEnquiryId,
      this.message,
      this.messageFrom,
      this.jobApplicantId,
      this.attachments,
      this.createdAt,
      this.updatedAt,
      this.deletedStatus,
      this.senderId,
      this.receiverId,
      this.senderType,
      this.receiverType,
      this.sTypename});

  JobApplicantMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobEnquiryId = json['job_enquiry_id'];
    message = json['message'];
    messageFrom = json['message_from'];
    attachments = json['attachments'];
    jobApplicantId = json['job_applicant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedStatus = json['deleted_status'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    senderType = json['sender_type'];
    receiverType = json['receiver_type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_enquiry_id'] = this.jobEnquiryId;
    data['message'] = this.message;
    data['message_from'] = this.messageFrom;
    data['attachments'] = this.attachments;
    data['job_applicant_id'] = this.jobApplicantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_status'] = this.deletedStatus;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['sender_type'] = this.senderType;
    data['receiver_type'] = this.receiverType;
    data['__typename'] = this.sTypename;

    return data;
  }
}
