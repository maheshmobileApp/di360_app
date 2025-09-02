
class EnquiriesRespo {
   EnquiriesData? data;

  EnquiriesRespo({required this.data});

 factory EnquiriesRespo.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      return EnquiriesRespo(
        data: json['data'] != null
            ?  EnquiriesData.fromJson(json['data'])
            : null,
      );
    } else if (json.containsKey('job_applicants')) {
      return EnquiriesRespo(
        data: EnquiriesData.fromJson(json),
      );
    } else {
      return EnquiriesRespo(data: EnquiriesData(jobApplicants: []));
    }
  }
     Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}


class EnquiriesData {
  List<EnquiriesJob>? jobApplicants;

  EnquiriesData({this.jobApplicants});

  factory EnquiriesData.fromJson(Map<String, dynamic> json) {
    return EnquiriesData(
      jobApplicants: json['job_applicants'] != null
          ? List<EnquiriesJob>.from(
              json['job_applicants'].map((x) =>EnquiriesJob.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_applicants': jobApplicants?.map((x) => x.toJson()).toList(),
    };
  }
}


class EnquiriesJob {
  String? id;
  String? jobId;
  Attachments? attachments;
  String? status;
  String? message;
  String? dentalProfessionalId;
  EnquiryJob? job;

  EnquiriesJob({
    this.id,
    this.jobId,
    this.attachments,
    this.status,
    this.message,
    this.dentalProfessionalId,
    this.job,
  });

  factory EnquiriesJob.fromJson(Map<String, dynamic> json) {
    return EnquiriesJob(
      id: json['id'],
      jobId: json['job_id'],
      attachments: json['attachments'] != null
          ? Attachments.fromJson(json['attachments'])
          : null,
      status: json['status'],
      message: json['message'],
      dentalProfessionalId: json['dental_professional_id'],
      job: json['job'] != null ? EnquiryJob.fromJson(json['job']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'attachments': attachments?.toJson(),
      'status': status,
      'message': message,
      'dental_professional_id': dentalProfessionalId,
      'job': job?.toJson(),
    };
  }
}

class Attachments {
  String? url;
  String? name;
  String? type;

  Attachments({this.url, this.name, this.type});

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      url: json['url'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'type': type,
    };
  }
}

class EnquiryJob {
  String? country;
  String? companyName;
  String? experience;
  String? salary;
  String? status;
  String? bannerImage;
  List<String>? typeofEmployment;
  String? activeStatus;
  String? createdAt;
  List<ClinicLogo>? clinicLogo;
  String? description;
  List<JobEnquiry>? jobEnquiries;

  EnquiryJob({
    this.country,
    this.companyName,
    this.experience,
    this.salary,
    this.status,
    this.bannerImage,
    this.typeofEmployment,
    this.activeStatus,
    this.createdAt,
    this.clinicLogo,
    this.description,
    this.jobEnquiries,
  });

  factory EnquiryJob.fromJson(Map<String, dynamic> json) {
    return EnquiryJob(
      country: json['country'],
      companyName: json['company_name'],
      experience: json['experience'],
      salary: json['salary'],
      status: json['status'],
      bannerImage: json['banner_image'],
      typeofEmployment: json['TypeofEmployment'] != null
          ? List<String>.from(json['TypeofEmployment'])
          : null,
      activeStatus: json['active_status'],
      createdAt: json['created_at'],
      clinicLogo: json['clinic_logo'] != null
          ? List<ClinicLogo>.from(
              json['clinic_logo'].map((x) => ClinicLogo.fromJson(x)))
          : [],
      description: json['description'],
      jobEnquiries: json['job_enquiries'] != null
          ? List<JobEnquiry>.from(
              json['job_enquiries'].map((x) => JobEnquiry.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'company_name': companyName,
      'experience': experience,
      'salary': salary,
      'status': status,
      'banner_image': bannerImage,
      'TypeofEmployment': typeofEmployment,
      'active_status': activeStatus,
      'created_at': createdAt,
      'clinic_logo': clinicLogo?.map((x) => x.toJson()).toList(),
      'description': description,
      'job_enquiries': jobEnquiries?.map((x) => x.toJson()).toList(),
    };
  }
}

class ClinicLogo {
  String? url;
  String? type;
  String? extension;

  ClinicLogo({this.url, this.type, this.extension});

  factory ClinicLogo.fromJson(Map<String, dynamic> json) {
    return ClinicLogo(
      url: json['url'],
      type: json['type'],
      extension: json['extension'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'type': type,
      'extension': extension,
    };
  }
}

class JobEnquiry {
  String? id;
  String? enquiryUserid;
  String? enquiryDescription;
  String? jobId;

  JobEnquiry({this.id, this.enquiryUserid, this.enquiryDescription, this.jobId});

  factory JobEnquiry.fromJson(Map<String, dynamic> json) {
    return JobEnquiry(
      id: json['id'],
      enquiryUserid: json['enquiry_userid'],
      enquiryDescription: json['enquiry_description'],
      jobId: json['job_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enquiry_userid': enquiryUserid,
      'enquiry_description': enquiryDescription,
      'job_id': jobId,
    };
  }
}