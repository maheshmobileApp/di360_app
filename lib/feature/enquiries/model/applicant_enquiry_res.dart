class ApplicantEnquiriesListRes {
  ApplicantEnquiryData? data;

  ApplicantEnquiriesListRes({this.data});

  ApplicantEnquiriesListRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ApplicantEnquiryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ApplicantEnquiryData {
  List<JobEnquiries>? jobEnquiries;

  ApplicantEnquiryData({this.jobEnquiries});

  ApplicantEnquiryData.fromJson(Map<String, dynamic> json) {
    if (json['job_enquiries'] != null) {
      jobEnquiries = <JobEnquiries>[];
      json['job_enquiries'].forEach((v) {
        jobEnquiries!.add(new JobEnquiries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobEnquiries != null) {
      data['job_enquiries'] =
          this.jobEnquiries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobEnquiries {
  String? id;
  String? jobId;
  String? createdAt;
  String? updatedAt;
  String? enquiryUserid;
  String? enquiryDescription;
  String? sTypename;

  JobEnquiries(
      {this.id,
      this.jobId,
      this.createdAt,
      this.updatedAt,
      this.enquiryUserid,
      this.enquiryDescription,
      this.sTypename});

  JobEnquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    enquiryUserid = json['enquiry_userid'];
    enquiryDescription = json['enquiry_description'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['enquiry_userid'] = this.enquiryUserid;
    data['enquiry_description'] = this.enquiryDescription;
    data['__typename'] = this.sTypename;
    return data;
  }
}
