class GetFilteredEnquiryRes {
  FilteredEnquiryData? data;

  GetFilteredEnquiryRes({this.data});

  GetFilteredEnquiryRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new FilteredEnquiryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FilteredEnquiryData {
  List<JobEnquiries>? jobEnquiries;

  FilteredEnquiryData({this.jobEnquiries});

  FilteredEnquiryData.fromJson(Map<String, dynamic> json) {
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
  String? enquiryUserid;
  String? enquiryDescription;
  DentalProfessional? dentalProfessional;
  JobProfiles? jobProfiles;
  JobApplicantsFind? jobApplicantsFind;
  String? sTypename;

  JobEnquiries(
      {this.id,
      this.jobId,
      this.enquiryUserid,
      this.enquiryDescription,
      this.dentalProfessional,
      this.jobProfiles,
      this.jobApplicantsFind,
      this.sTypename});

  JobEnquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    enquiryUserid = json['enquiry_userid'];
    enquiryDescription = json['enquiry_description'];
    dentalProfessional = json['dental_professional'] != null
        ? new DentalProfessional.fromJson(json['dental_professional'])
        : null;
    jobProfiles = json['job_profiles'] != null
        ? new JobProfiles.fromJson(json['job_profiles'])
        : null;
    jobApplicantsFind = json['job_applicants_find'] != null
        ? new JobApplicantsFind.fromJson(json['job_applicants_find'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['enquiry_userid'] = this.enquiryUserid;
    data['enquiry_description'] = this.enquiryDescription;
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    if (this.jobProfiles != null) {
      data['job_profiles'] = this.jobProfiles!.toJson();
    }
    if (this.jobApplicantsFind != null) {
      data['job_applicants_find'] = this.jobApplicantsFind!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalProfessional {
  String? name;
  String? email;
  String? phone;
  String? lastName;
  String? firstName;
  ProfileImage? profileImage;
  String? createdAt;
  String? sTypename;

  DentalProfessional(
      {this.name,
      this.email,
      this.phone,
      this.lastName,
      this.firstName,
      this.profileImage,
      this.createdAt,
      this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    createdAt = json['created_at'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['created_at'] = this.createdAt;
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

class JobProfiles {
  ProfileImage? profileImage;
  String? fullName;
  List<ProfileImage>? uploadResume;
  String? professionType;
  String? location;
  Null? country;
  String? sTypename;

  JobProfiles(
      {this.profileImage,
      this.fullName,
      this.uploadResume,
      this.professionType,
      this.location,
      this.country,
      this.sTypename});

  JobProfiles.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    fullName = json['full_name'];
    if (json['upload_resume'] != null) {
      uploadResume = <ProfileImage>[];
      json['upload_resume'].forEach((v) {
        uploadResume!.add(new ProfileImage.fromJson(v));
      });
    }
    professionType = json['profession_type'];
    location = json['location'];
    country = json['country'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['full_name'] = this.fullName;
    if (this.uploadResume != null) {
      data['upload_resume'] =
          this.uploadResume!.map((v) => v.toJson()).toList();
    }
    data['profession_type'] = this.professionType;
    data['location'] = this.location;
    data['country'] = this.country;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class JobApplicantsFind {
  String? id;
  String? sTypename;

  JobApplicantsFind({this.id, this.sTypename});

  JobApplicantsFind.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['__typename'] = this.sTypename;
    return data;
  }
}
