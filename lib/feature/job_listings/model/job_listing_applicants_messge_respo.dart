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
  String? messageFrom;
  String? createdAt;
  String? updatedAt;
  bool? deletedStatus;

  JobApplicantMessage({
    this.id,
    this.jobApplicantId,
    this.jobEnquiryId,
    this.message,
    this.messageFrom,
    this.createdAt,
    this.updatedAt,
    this.deletedStatus,
  });

  JobApplicantMessage.fromJson(Map<String, dynamic> json) {
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
