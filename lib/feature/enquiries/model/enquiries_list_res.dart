class EnquiriesListRes {
  EnquiriesListResData? data;

  EnquiriesListRes({this.data});

  EnquiriesListRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new EnquiriesListResData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EnquiriesListResData {
  List<JobEnquiries>? jobEnquiries;

  EnquiriesListResData({this.jobEnquiries});

  EnquiriesListResData.fromJson(Map<String, dynamic> json) {
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
  String? enquiryUserid;
  DentalProfessional? dentalProfessional;
  Null? jobs;
  Null? jobApplicantsFind;
  String? sTypename;

  JobEnquiries(
      {this.id,
      this.jobId,
      this.createdAt,
      this.enquiryUserid,
      this.dentalProfessional,
      this.jobs,
      this.jobApplicantsFind,
      this.sTypename});

  JobEnquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    createdAt = json['created_at'];
    enquiryUserid = json['enquiry_userid'];
    dentalProfessional = json['dental_professional'] != null
        ? new DentalProfessional.fromJson(json['dental_professional'])
        : null;
    jobs = json['jobs'];
    jobApplicantsFind = json['job_applicants_find'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['created_at'] = this.createdAt;
    data['enquiry_userid'] = this.enquiryUserid;
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    data['jobs'] = this.jobs;
    data['job_applicants_find'] = this.jobApplicantsFind;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalProfessional {
  ProfileImage? profileImage;
  String? sTypename;

  DentalProfessional({this.profileImage, this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProfileImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  ProfileImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  ProfileImage.fromJson(Map<String, dynamic> json) {
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
