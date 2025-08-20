class JobApplicantsResponse {
  JobApplicantsData? data;

  JobApplicantsResponse({this.data});

  factory JobApplicantsResponse.fromJson(Map<String, dynamic> json) {
    return JobApplicantsResponse(
      data: json['data'] != null ? JobApplicantsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class JobApplicantsData {
  List<JobApplicant>? jobApplicants;

JobApplicantsData({this.jobApplicants});

  factory JobApplicantsData.fromJson(Map<String, dynamic> json) {
    return JobApplicantsData(
      jobApplicants: json['job_applicants'] != null
          ? (json['job_applicants'] as List)
              .map((e) => JobApplicant.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_applicants': jobApplicants?.map((e) => e.toJson()).toList(),
    };
  }
}

class JobApplicant {
  String? id;
  String? jobId;
  List<dynamic>? attachments;
  String? status;
  String? firstName;
  String? cityName;
  String? dentalProfessionalId;
  DentalProfessional? dentalProfessional;
  List<dynamic>? jobApplicantMessages;
  List<JobEnquiry>? jobEnquiries;

  JobApplicant({
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

  factory JobApplicant.fromJson(Map<String, dynamic> json) {
    return JobApplicant(
      id: json['id'],
      jobId: json['job_id'],
      attachments: json['attachments'] ?? [],
      status: json['status'],
      firstName: json['first_name'],
      cityName: json['city_name'],
      dentalProfessionalId: json['dental_professional_id'],
      dentalProfessional: json['dental_professional'] != null
          ? DentalProfessional.fromJson(json['dental_professional'])
          : null,
      jobApplicantMessages: json['job_applicant_messages'] ?? [],
      jobEnquiries: json['job_enquiries'] != null
          ? (json['job_enquiries'] as List)
              .map((e) => JobEnquiry.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'attachments': attachments,
      'status': status,
      'first_name': firstName,
      'city_name': cityName,
      'dental_professional_id': dentalProfessionalId,
      'dental_professional': dentalProfessional?.toJson(),
      'job_applicant_messages': jobApplicantMessages,
      'job_enquiries': jobEnquiries?.map((e) => e.toJson()).toList(),
    };
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

  DentalProfessional({
    this.name,
    this.email,
    this.phone,
    this.lastName,
    this.firstName,
    this.profileImage,
    this.createdAt,
  });

  factory DentalProfessional.fromJson(Map<String, dynamic> json) {
    return DentalProfessional(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      lastName: json['last_name'],
      firstName: json['first_name'],
      profileImage: json['profile_image'] != null
          ? ProfileImage.fromJson(json['profile_image'])
          : null,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'last_name': lastName,
      'first_name': firstName,
      'profile_image': profileImage?.toJson(),
      'created_at': createdAt,
    };
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

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      url: json['url'],
      name: json['name'],
      size: json['size'],
      status: json['status'],
      fileId: json['file_id'],
      isPublic: json['isPublic'],
      directory: json['directory'],
      extension: json['extension'],
      mimeType: json['mime_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'size': size,
      'status': status,
      'file_id': fileId,
      'isPublic': isPublic,
      'directory': directory,
      'extension': extension,
      'mime_type': mimeType,
    };
  }
}

class JobEnquiry {
  String? id;
  String? enquiryUserId;
  String? enquiryDescription;
  String? jobId;

  JobEnquiry({
    this.id,
    this.enquiryUserId,
    this.enquiryDescription,
    this.jobId,
  });

  factory JobEnquiry.fromJson(Map<String, dynamic> json) {
    return JobEnquiry(
      id: json['id'],
      enquiryUserId: json['enquiry_userid'],
      enquiryDescription: json['enquiry_description'],
      jobId: json['job_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enquiry_userid': enquiryUserId,
      'enquiry_description': enquiryDescription,
      'job_id': jobId,
    };
  }
}
