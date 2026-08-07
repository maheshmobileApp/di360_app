class JobListingTalentsMessageResponse {
  List<TalentsMessage>? messages;

  JobListingTalentsMessageResponse({this.messages});

  JobListingTalentsMessageResponse.fromJson(Map<String, dynamic> json) {
    if (json['talents_message'] != null) {
      messages = <TalentsMessage>[];
      json['talents_message'].forEach((v) {
        messages!.add(TalentsMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (messages != null) {
      data['talents_message'] =
          messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TalentsMessage  {
  String? id;
  String? jobApplicantId;
  String? jobEnquiryId;
  String? message;
  String? messageFrom;
  String? createdAt;
  String? updatedAt;
  bool? deletedStatus;

  TalentsMessage ({
    this.id,
    this.jobApplicantId,
    this.jobEnquiryId,
    this.message,
    this.messageFrom,
    this.createdAt,
    this.updatedAt,
    this.deletedStatus,
  });

  TalentsMessage .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobApplicantId = json['job_applicant_id'];
    jobEnquiryId = json['job_enquiry_id'];
    message = json['message'];
    messageFrom = json['message_from'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedStatus = json['deleted_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['job_applicant_id'] = jobApplicantId;
    data['job_enquiry_id'] = jobEnquiryId;
    data['message'] = message;
    data['message_from'] = messageFrom;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_status'] = deletedStatus;
    return data;
  }
}
