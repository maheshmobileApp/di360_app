class JobApplicantsResponse {
  JobApplicantsData? data;
  JobApplicantsResponse({this.data});

  JobApplicantsResponse.fromJson(Map<String, dynamic> json) {
    final root = json['data'] is Map<String, dynamic> ? json['data'] as Map<String, dynamic> : json;
    data = JobApplicantsData.fromJson(root);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
class JobApplicantsData {
  List<JobApplicants>? jobApplicants;

  JobApplicantsData({this.jobApplicants});

  JobApplicantsData.fromJson(Map<String, dynamic> json) {
    final raw = json['job_applicants'];
    if (raw is List) {
      jobApplicants = raw
          .whereType<Map<String, dynamic>>()
          .map(JobApplicants.fromJson)
          .toList();
    } else if (raw is Map<String, dynamic>) {
      jobApplicants = [JobApplicants.fromJson(raw)];
    } else {
      jobApplicants = <JobApplicants>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (jobApplicants != null) {
      data['job_applicants'] = jobApplicants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobApplicants {
  String? id;
  String? jobId;
  List<Attachments>? attachments;
  String? status;
  String? firstName;
  String? cityName;
  String? dentalProfessionalId;
  DentalProfessional? dentalProfessional;
  List<dynamic>? jobApplicantMessages;
  List<JobEnquiries>? jobEnquiries;

  JobApplicants({
    this.id,
    this.jobId,
    this.attachments,
    this.status,
    this.firstName,
    this.cityName,
    this.dentalProfessionalId,
    this.dentalProfessional,
    this.jobApplicantMessages,
    this.jobEnquiries,
  });

  JobApplicants.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    jobId = json['job_id'] as String?;
    final atts = json['attachments'];
    if (atts is List) {
      attachments = atts
          .whereType<Map<String, dynamic>>()
          .map(Attachments.fromJson)
          .toList();
    } else if (atts is Map<String, dynamic>) {
      attachments = [Attachments.fromJson(atts)];
    } else {
      attachments = <Attachments>[];
    }

    status = json['status'] as String?;
    firstName = json['first_name'] as String?;
    cityName = json['city_name'] as String?;
    dentalProfessionalId = json['dental_professional_id'] as String?;

    final dp = json['dental_professional'];
    dentalProfessional = (dp is Map<String, dynamic>)
        ? DentalProfessional.fromJson(dp)
        : null;
    final msgs = json['job_applicant_messages'];
    if (msgs is List) {
      jobApplicantMessages = msgs;
    } else if (msgs == null) {
      jobApplicantMessages = <dynamic>[];
    } else {
      
      jobApplicantMessages = [msgs];
    }
    final enqu = json['job_enquiries'];
    if (enqu is List) {
      jobEnquiries = enqu
          .whereType<Map<String, dynamic>>()
          .map(JobEnquiries.fromJson)
          .toList();
    } else if (enqu is Map<String, dynamic>) {
      jobEnquiries = [JobEnquiries.fromJson(enqu)];
    } else {
      jobEnquiries = <JobEnquiries>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['job_id'] = jobId;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['first_name'] = firstName;
    data['city_name'] = cityName;
    data['dental_professional_id'] = dentalProfessionalId;
    if (dentalProfessional != null) {
      data['dental_professional'] = dentalProfessional!.toJson();
    }
    if (jobApplicantMessages != null) {
      data['job_applicant_messages'] = jobApplicantMessages;
    }
    if (jobEnquiries != null) {
      data['job_enquiries'] = jobEnquiries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  Attachments();
  Attachments.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {};
}

class DentalProfessional {
  String? name;
  String? email;
  String? phone;
  String? lastName;
  String? firstName;
  ProfileImage? profileImage;
  String? createdAt;

  DentalProfessional({
    this.name,
    this.email,
    this.phone,
    this.lastName,
    this.firstName,
    this.profileImage,
    this.createdAt,
  });

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    email = json['email'] as String?;
    phone = json['phone'] as String?;
    lastName = json['last_name'] as String?;
    firstName = json['first_name'] as String?;
    final pi = json['profile_image'];
    profileImage =
        (pi is Map<String, dynamic>) ? ProfileImage.fromJson(pi) : null;
    createdAt = json['created_at'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    if (profileImage != null) data['profile_image'] = profileImage!.toJson();
    data['created_at'] = createdAt;
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

  ProfileImage({
    this.url,
    this.name,
    this.size,
    this.status,
    this.fileId,
    this.isPublic,
    this.directory,
    this.extension,
    this.mimeType,
  });

  ProfileImage.fromJson(Map<String, dynamic> json) {
    url = json['url'] as String?;
    name = json['name'] as String?;
    size = json['size'] as int?;
    status = json['status'] as String?;
    fileId = json['file_id'] as String?;
    isPublic = json['isPublic'] as bool?;
    directory = json['directory'] as String?;
    extension = json['extension'] as String?;
    mimeType = json['mime_type'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['name'] = name;
    data['size'] = size;
    data['status'] = status;
    data['file_id'] = fileId;
    data['isPublic'] = isPublic;
    data['directory'] = directory;
    data['extension'] = extension;
    data['mime_type'] = mimeType;
    return data;
  }
}

class JobEnquiries {
  String? id;
  String? enquiryUserid;
  String? enquiryDescription;
  String? jobId;

  JobEnquiries({this.id, this.enquiryUserid, this.enquiryDescription, this.jobId});

  JobEnquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    enquiryUserid = json['enquiry_userid'] as String?;
    enquiryDescription = json['enquiry_description'] as String?;
    jobId = json['job_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['enquiry_userid'] = enquiryUserid;
    data['enquiry_description'] = enquiryDescription;
    data['job_id'] = jobId;
    return data;
  }
}
