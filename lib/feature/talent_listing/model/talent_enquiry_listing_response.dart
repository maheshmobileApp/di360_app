class TalentEnquiryListResponse {
  final List<TalentEnquiry> talentEnquiries;

  TalentEnquiryListResponse({required this.talentEnquiries});

  factory TalentEnquiryListResponse.fromJson(Map<String, dynamic> json) {

    final list = json['data']?['talent_enquiries'] as List<dynamic>? ?? [];
    return TalentEnquiryListResponse(
      talentEnquiries: list.map((e) => TalentEnquiry.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': {
          'talent_enquiries': talentEnquiries.map((e) => e.toJson()).toList(),
        }
      };
}

class TalentEnquiry {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? talentId;
  final String? enquiryDescription;
  final String? enquiryFrom;
  final JobProfile? jobProfile;

  TalentEnquiry({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.talentId,
    this.enquiryDescription,
    this.enquiryFrom,
    this.jobProfile,
  });

  factory TalentEnquiry.fromJson(Map<String, dynamic> json) => TalentEnquiry(
        id: json['id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        talentId: json['talent_id'],
        enquiryDescription: json['enquiry_description'],
        enquiryFrom: json['enquiry_from'],
        jobProfile: json['job_profiles'] != null
            ? JobProfile.fromJson(json['job_profiles'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'talent_id': talentId,
        'enquiry_description': enquiryDescription,
        'enquiry_from': enquiryFrom,
        'job_profiles': jobProfile?.toJson(),
      };
}

class JobProfile {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final List<String> skills;
  final List<JobExperience> jobExperiences;
  final List<FileUpload> uploadResume;
  final String? jobLocation;
  final String? jobDesignation;
  final String? currentCompany;
  final String? currentCtc;
  final String? dentalProfessionalId;
  final bool? postAnonymously;
  final String? adminStatus;
  final List<ProfileImage> profileImage;
  final String? professionType;
  final List<String> workType;
  final String? state;
  final String? city;
  final String? fullName;
  final String? languagesSpoken;
  final String? availabilityOption;
  final List<String> availabilityDate;
  final String? yearOfExperience;
  final List<String> availabilityDay;
  final DentalProfessional? dentalProfessional;
  final List<JobHiring> jobHirings;
  final List<SubTalentEnquiry> talentEnquiries;

  JobProfile({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.skills = const [],
    this.jobExperiences = const [],
    this.uploadResume = const [],
    this.jobLocation,
    this.jobDesignation,
    this.currentCompany,
    this.currentCtc,
    this.dentalProfessionalId,
    this.postAnonymously,
    this.adminStatus,
    this.profileImage = const [],
    this.professionType,
    this.workType = const [],
    this.state,
    this.city,
    this.fullName,
    this.languagesSpoken,
    this.availabilityOption,
    this.availabilityDate = const [],
    this.yearOfExperience,
    this.availabilityDay = const [],
    this.dentalProfessional,
    this.jobHirings = const [],
    this.talentEnquiries = const [],
  });

  factory JobProfile.fromJson(Map<String, dynamic> json) => JobProfile(
        id: json['id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        skills: (json['skills'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
        jobExperiences: (json['job_experiences'] as List<dynamic>? ?? [])
            .map((e) => JobExperience.fromJson(e))
            .toList(),
        uploadResume: (json['upload_resume'] as List<dynamic>? ?? [])
            .map((e) => FileUpload.fromJson(e))
            .toList(),
        jobLocation: json['job_location'],
        jobDesignation: json['job_designation'],
        currentCompany: json['current_company'],
        currentCtc: json['current_ctc'],
        dentalProfessionalId: json['dental_professional_id'],
        postAnonymously: json['post_anonymously'],
        adminStatus: json['admin_status'],
        profileImage: (json['profile_image'] as List<dynamic>? ?? [])
            .map((e) => ProfileImage.fromJson(e))
            .toList(),
        professionType: json['profession_type'],
        workType: (json['work_type'] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
        state: json['state'],
        city: json['city'],
        fullName: json['full_name'],
        languagesSpoken: json['languages_spoken'],
        availabilityOption: json['availability_option'],
        availabilityDate: (json['availability_date'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
        yearOfExperience: json['year_of_experience'],
        availabilityDay: (json['availability_day'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
        dentalProfessional: json['dental_professional'] != null
            ? DentalProfessional.fromJson(json['dental_professional'])
            : null,
        jobHirings: (json['job_hirings'] as List<dynamic>? ?? [])
            .map((e) => JobHiring.fromJson(e))
            .toList(),
        talentEnquiries: (json['talent_enquiries'] as List<dynamic>? ?? [])
            .map((e) => SubTalentEnquiry.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'skills': skills,
        'job_experiences': jobExperiences.map((e) => e.toJson()).toList(),
        'upload_resume': uploadResume.map((e) => e.toJson()).toList(),
        'job_location': jobLocation,
        'job_designation': jobDesignation,
        'current_company': currentCompany,
        'current_ctc': currentCtc,
        'dental_professional_id': dentalProfessionalId,
        'post_anonymously': postAnonymously,
        'admin_status': adminStatus,
        'profile_image': profileImage.map((e) => e.toJson()).toList(),
        'profession_type': professionType,
        'work_type': workType,
        'state': state,
        'city': city,
        'full_name': fullName,
        'languages_spoken': languagesSpoken,
        'availability_option': availabilityOption,
        'availability_date': availabilityDate,
        'year_of_experience': yearOfExperience,
        'availability_day': availabilityDay,
        'dental_professional': dentalProfessional?.toJson(),
        'job_hirings': jobHirings.map((e) => e.toJson()).toList(),
        'talent_enquiries': talentEnquiries.map((e) => e.toJson()).toList(),
      };
}

class JobExperience {
  final String? ejobdesp;
  final String? jobTitle;
  final int? startYear;
  final String? startMonth;
  final bool? stillInRole;
  final String? companyName;

  JobExperience({
    this.ejobdesp,
    this.jobTitle,
    this.startYear,
    this.startMonth,
    this.stillInRole,
    this.companyName,
  });

  factory JobExperience.fromJson(Map<String, dynamic> json) => JobExperience(
        ejobdesp: json['ejobdesp'],
        jobTitle: json['job_title'],
        startYear: json['start_year'],
        startMonth: json['start_month'],
        stillInRole: json['still_in_role'],
        companyName: json['company_name'],
      );

  Map<String, dynamic> toJson() => {
        'ejobdesp': ejobdesp,
        'job_title': jobTitle,
        'start_year': startYear,
        'start_month': startMonth,
        'still_in_role': stillInRole,
        'company_name': companyName,
      };
}

class FileUpload {
  final String? url;
  final String? name;
  final String? type;
  final String? extension;

  FileUpload({this.url, this.name, this.type, this.extension});

  factory FileUpload.fromJson(Map<String, dynamic> json) => FileUpload(
        url: json['url'],
        name: json['name'],
        type: json['type'],
        extension: json['extension'],
      );

  Map<String, dynamic> toJson() =>
      {'url': url, 'name': name, 'type': type, 'extension': extension};
}

class ProfileImage {
  final String? url;
  final String? name;
  final String? type;
  final String? extension;

  ProfileImage({this.url, this.name, this.type, this.extension});

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        url: json['url'],
        name: json['name'],
        type: json['type'],
        extension: json['extension'],
      );

  Map<String, dynamic> toJson() =>
      {'url': url, 'name': name, 'type': type, 'extension': extension};
}

class DentalProfessional {
  final String? id;
  final ProfileImage? profileImage;
  final List<DirectoryItem> directories;

  DentalProfessional({this.id, this.profileImage, this.directories = const []});

  factory DentalProfessional.fromJson(Map<String, dynamic> json) =>
      DentalProfessional(
        id: json['id'],
        profileImage: json['profile_image'] != null &&
                json['profile_image'] is Map<String, dynamic>
            ? ProfileImage.fromJson(json['profile_image'])
            : null,
        directories: (json['directories'] as List<dynamic>? ?? [])
            .map((e) => DirectoryItem.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'profile_image': profileImage?.toJson(),
        'directories': directories.map((e) => e.toJson()).toList(),
      };
}

class DirectoryItem {
  final String? id;
  final String? dentalProfessionalId;
  final String? logo;
  final ProfileImage? profileImage;

  DirectoryItem({
    this.id,
    this.dentalProfessionalId,
    this.logo,
    this.profileImage,
  });

  factory DirectoryItem.fromJson(Map<String, dynamic> json) => DirectoryItem(
        id: json['id'],
        dentalProfessionalId: json['dental_professional_id'],
        logo: json['logo'],
        profileImage: json['profile_image'] != null
            ? ProfileImage.fromJson(json['profile_image'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'dental_professional_id': dentalProfessionalId,
        'logo': logo,
        'profile_image': profileImage?.toJson(),
      };
}

class JobHiring {
  final String? id;
  final String? createdAt;
  final String? dentalSupplierId;
  final String? dentalProfessionalId;
  final String? hiringStatus;
  final String? jobProfilesId;

  JobHiring({
    this.id,
    this.createdAt,
    this.dentalSupplierId,
    this.dentalProfessionalId,
    this.hiringStatus,
    this.jobProfilesId,
  });

  factory JobHiring.fromJson(Map<String, dynamic> json) => JobHiring(
        id: json['id'],
        createdAt: json['created_at'],
        dentalSupplierId: json['dental_supplier_id'],
        dentalProfessionalId: json['dental_professional_id'],
        hiringStatus: json['hiring_status'],
        jobProfilesId: json['job_profiles_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'dental_supplier_id': dentalSupplierId,
        'dental_professional_id': dentalProfessionalId,
        'hiring_status': hiringStatus,
        'job_profiles_id': jobProfilesId,
      };
}

class SubTalentEnquiry {
  final String? id;
  final String? talentId;
  final String? enquiryDescription;
  final String? enquiryFrom;
  final String? createdAt;
  final String? updatedAt;

  SubTalentEnquiry({
    this.id,
    this.talentId,
    this.enquiryDescription,
    this.enquiryFrom,
    this.createdAt,
    this.updatedAt,
  });

  factory SubTalentEnquiry.fromJson(Map<String, dynamic> json) =>
      SubTalentEnquiry(
        id: json['id'],
        talentId: json['talent_id'],
        enquiryDescription: json['enquiry_description'],
        enquiryFrom: json['enquiry_from'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'talent_id': talentId,
        'enquiry_description': enquiryDescription,
        'enquiry_from': enquiryFrom,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
