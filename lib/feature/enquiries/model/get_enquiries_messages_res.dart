class GetEnquiriesMessagesRes {
  EnquiriesMessagesData? data;

  GetEnquiriesMessagesRes({this.data});

  GetEnquiriesMessagesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new EnquiriesMessagesData.fromJson(json['data']) : null;
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
  Null? attachments;

  JobApplicantMessages(
      {this.id,
      this.jobEnquiryId,
      this.message,
      this.messageFrom,
      this.attachments});

  JobApplicantMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobEnquiryId = json['job_enquiry_id'];
    message = json['message'];
    messageFrom = json['message_from'];
    attachments = json['attachments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_enquiry_id'] = this.jobEnquiryId;
    data['message'] = this.message;
    data['message_from'] = this.messageFrom;
    data['attachments'] = this.attachments;
    return data;
  }
}
