class JobListingApplicantsMessageResponse {
  List<JobApplicantMessage>? messages;

  JobListingApplicantsMessageResponse({this.messages});

  JobListingApplicantsMessageResponse.fromJson(Map<String, dynamic> json) {
    if (json['job_applicant_messages'] != null) {
      messages = <JobApplicantMessage>[];
      json['job_applicant_messages'].forEach((v) {
        messages!.add(JobApplicantMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (messages != null) {
      data['job_applicant_messages'] =
          messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobApplicantMessage {
  String? id;
  String? jobApplicantId;
  String? jobEnquiryId;
  String? message;
  String? createdAt;
  String? updatedAt;
  bool? deletedStatus;
  String? senderId;
  String? receiverId;
  String? senderType;
  String? receiverType;
  String? sTypename;

  JobApplicantMessage(
      {this.id,
      this.jobApplicantId,
      this.jobEnquiryId,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.deletedStatus,
      this.senderId,
      this.receiverId,
      this.senderType,
      this.receiverType,
      this.sTypename});

  JobApplicantMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobApplicantId = json['job_applicant_id'];
    jobEnquiryId = json['job_enquiry_id'];
    message = json['message'];
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['job_applicant_id'] = jobApplicantId;
    data['job_enquiry_id'] = jobEnquiryId;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_status'] = deletedStatus;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['sender_type'] = this.senderType;
    data['receiver_type'] = this.receiverType;
    data['__typename'] = this.sTypename;
    return data;
  }
}
