import 'package:di360_flutter/common/model/certificates.dart';
import 'package:di360_flutter/feature/add_directors/model/get_directories_res.dart';

class TalentsRes {
  TalentsResData? data;

  TalentsRes({this.data});

  TalentsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TalentsResData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentsResData {
  List<JobProfiles>? jobProfiles;

  TalentsResData({this.jobProfiles});

  TalentsResData.fromJson(Map<String, dynamic> json) {
    if (json['job_profiles'] != null) {
      jobProfiles = <JobProfiles>[];
      json['job_profiles'].forEach((v) {
        jobProfiles!.add(new JobProfiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobProfiles != null) {
      data['job_profiles'] = this.jobProfiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobProfiles {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final List<String>? skills;
  final List<JobExperience> jobExperiences;
  final List<Education> educations;
  final List<FileUpload> uploadResume;
  final String? jobDesignation;
  final String? currentCompany;
  final String? currentCtc;
  final String? dentalProfessionalId;
  final bool postAnonymously;
  final String? adminStatus;
  final String? activeStatus;
  final List<FileUpload> profileImage;
  final String? fullName;
  final String? mobileNumber;
  final String? emailAddress;
  final List<String> workType;
  final String? professionType;
  final String? location;
  final String? country;
  final String? city;
  final String? state;
  final List<FileUpload> coverLetter;
  final List<FileUpload> certificate;
  final String? radius;
  final String? abnNumber;
  final String? availabilityOption;
  final List<String> availabilityDate;
  final List<String> fromDate;
  final List<String> availabilityDay;
  final String? workRights;
  final String? yearOfExperience;
  final List<String> languagesSpoken;
  final List<String> areasExpertise;
  final String? percentage;
  final int? salaryAmount;
  final String? salaryType;
  final String? aphraNumber;
  final bool willingToTravel;
  final String? travelDistance;
  final String? aboutYourself;
  final String? availabilityType;
  final List<String> unavailabilityDate;
  final DentalProfessional? dentalProfessional;
  final List<JobHiring> jobHirings;
  final List<TalentEnquiries>? talentEnquiries;
  JobProfiles(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.skills,
      required this.jobExperiences,
      required this.educations,
      required this.uploadResume,
      this.jobDesignation,
      this.currentCompany,
      this.currentCtc,
      this.dentalProfessionalId,
      this.postAnonymously = false,
      this.adminStatus,
      this.activeStatus,
      required this.profileImage,
      this.fullName,
      this.mobileNumber,
      this.emailAddress,
      required this.workType,
      this.professionType,
      this.location,
      this.country,
      this.city,
      this.state,
      required this.coverLetter,
      required this.certificate,
      this.radius,
      this.abnNumber,
      this.availabilityOption,
      required this.availabilityDate,
      required this.fromDate,
      required this.availabilityDay,
      this.workRights,
      this.yearOfExperience,
      required this.languagesSpoken,
      required this.areasExpertise,
      this.percentage,
      this.salaryAmount,
      this.salaryType,
      this.aphraNumber,
      this.willingToTravel = false,
      this.travelDistance,
      this.aboutYourself,
      this.availabilityType,
      required this.unavailabilityDate,
      this.dentalProfessional,
      required this.jobHirings,
      this.talentEnquiries});

  factory JobProfiles.fromJson(Map<String, dynamic> json) {
    List<String> normalizeStringList(dynamic value) {
      if (value == null) return [];
      if (value is String && value.isNotEmpty) return [value];
      if (value is List) return value.map((e) => e.toString()).toList();
      return [];
    }

    List<FileUpload> parseFileUploadList(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value
            .map((e) => e is Map<String, dynamic>
                ? FileUpload.fromJson(e)
                : FileUpload(url: e.toString()))
            .toList();
      }
      return [];
    }

    List<JobExperience> parseJobExperiences(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.map((e) => JobExperience.fromJson(e)).toList();
      }
      return [];
    }

    List<Education> parseEducations(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.map((e) => Education.fromJson(e)).toList();
      }
      return [];
    }

    List<JobHiring> parseJobHirings(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.map((e) => JobHiring.fromJson(e)).toList();
      }
      return [];
    }

    List<TalentEnquiries> parseTalentEnquiries(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.map((e) => TalentEnquiries.fromJson(e)).toList();
      }
      return [];
    }

    return JobProfiles(
      id: json['id']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      skills: normalizeStringList(json['skills']),
      jobExperiences: parseJobExperiences(json['jobexperiences']),
      educations: parseEducations(json['educations']),
      uploadResume: parseFileUploadList(json['upload_resume']),
      jobDesignation: json['job_designation']?.toString(),
      currentCompany: json['current_company']?.toString(),
      currentCtc: json['current_ctc']?.toString(),
      dentalProfessionalId: json['dental_professional_id']?.toString(),
      postAnonymously: json['post_anonymously'] ?? false,
      adminStatus: json['admin_status']?.toString(),
      activeStatus: json['active_status']?.toString(),
      profileImage: parseFileUploadList(json['profile_image']),
      fullName: json['full_name']?.toString(),
      mobileNumber: json['mobile_number']?.toString(),
      emailAddress: json['email_address']?.toString(),
      workType: normalizeStringList(json['work_type']),
      professionType: json['profession_type']?.toString(),
      location: json['location']?.toString(),
      country: json['country']?.toString(),
      city: json['city']?.toString(),
      state: json['state']?.toString(),
      coverLetter: parseFileUploadList(json['cover_letter']),
      certificate: parseFileUploadList(json['certificate']),
      radius: json['radius']?.toString(),
      abnNumber: json['abn_number']?.toString(),
      availabilityOption: json['availabilityOption']?.toString(),
      availabilityDate: normalizeStringList(json['availabilityDate']),
      fromDate: normalizeStringList(json['fromDate']),
      availabilityDay: normalizeStringList(json['availabilityDay']),
      workRights: json['work_rights']?.toString(),
      yearOfExperience: json['year_of_experience']?.toString(),
      languagesSpoken: normalizeStringList(json['languages_spoken']),
      areasExpertise: normalizeStringList(json['areas_expertise']),
      percentage: json['percentage']?.toString(),
      salaryAmount: json['salary_amount'] is int
          ? json['salary_amount']
          : int.tryParse(json['salary_amount']?.toString() ?? ''),
      salaryType: json['salary_type']?.toString(),
      aphraNumber: json['aphra_number']?.toString(),
      willingToTravel: json['willing_to_travel'] ?? false,
      travelDistance: json['travel_distance']?.toString(),
      aboutYourself: json['about_yourself']?.toString(),
      availabilityType: json['availabilityType']?.toString(),
      unavailabilityDate: normalizeStringList(json['unavailabilityDate']),
      dentalProfessional: json['dental_professional'] != null
          ? DentalProfessional.fromJson(json['dental_professional'])
          : null,
      jobHirings: parseJobHirings(json['jobhirings']),
      talentEnquiries: parseTalentEnquiries(json['talent_enquiries']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'skills': skills,
        'job_experiences': jobExperiences.map((e) => e.toJson()).toList(),
        'educations': educations.map((e) => e.toJson()).toList(),
        'upload_resume': uploadResume.map((e) => e.toJson()).toList(),
        'job_designation': jobDesignation,
        'current_company': currentCompany,
        'current_ctc': currentCtc,
        'dental_professional_id': dentalProfessionalId,
        'post_anonymously': postAnonymously,
        'admin_status': adminStatus,
        'active_status': activeStatus,
        'profile_image': profileImage.map((e) => e.toJson()).toList(),
        'full_name': fullName,
        'mobile_number': mobileNumber,
        'email_address': emailAddress,
        'work_type': workType,
        'profession_type': professionType,
        'location': location,
        'country': country,
        'city': city,
        'state': state,
        'cover_letter': coverLetter.map((e) => e.toJson()).toList(),
        'certificate': certificate.map((e) => e.toJson()).toList(),
        'radius': radius,
        'abn_number': abnNumber,
        'availabilityOption': availabilityOption,
        'availabilityDate': availabilityDate,
        'fromDate': fromDate,
        'availabilityDay': availabilityDay,
        'work_rights': workRights,
        'languages_spoken': List<String>.from(languagesSpoken),
        'areas_expertise': List<String>.from(areasExpertise),
        'percentage': percentage,
        'salary_amount': salaryAmount,
        'salary_type': salaryType,
        'aphra_number': aphraNumber,
        'willing_to_travel': willingToTravel,
        'travel_distance': travelDistance,
        'about_yourself': aboutYourself,
        'availabilityType': availabilityType,
        'unavailabilityDate': unavailabilityDate,
        'dental_professional': dentalProfessional?.toJson(),
        'jobhirings': jobHirings.map((e) => e.toJson()).toList(),
        'talent_enquiries':
            talentEnquiries?.map((e) => e.toJson()).toList() ?? [],
      };
}

class JobExperience {
  final dynamic endYear;
  final String? jobDescription;
  final String? endMonth;
  final String? jobTitle;
  final dynamic startYear;
  final String? startMonth;
  final bool? stillInRole;
  final String? companyName;

  JobExperience({
    this.endYear,
    this.jobDescription,
    this.endMonth,
    this.jobTitle,
    this.startYear,
    this.startMonth,
    this.stillInRole,
    this.companyName,
  });

  factory JobExperience.fromJson(Map<String, dynamic> json) => JobExperience(
        endYear: json['endYear'],
        jobDescription: json['ejobdesp'],
        endMonth: json['endMonth'],
        jobTitle: json['job_title'],
        startYear: json['startYear'],
        startMonth: json['startMonth'],
        stillInRole: json['stillInRole'],
        companyName: json['company_name'],
      );

  Map<String, dynamic> toJson() => {
        'endYear': endYear,
        'ejobdesp': jobDescription,
        'endMonth': endMonth,
        'job_title': jobTitle,
        'startYear': startYear,
        'startMonth': startMonth,
        'stillInRole': stillInRole,
        'company_name': companyName,
      };
}

class DentalProfessional {
  final String? id;
  final String? gender;
  final String? typeName;

  DentalProfessional({this.id, this.gender, this.typeName});

  factory DentalProfessional.fromJson(Map<String, dynamic> json) =>
      DentalProfessional(
        id: json['id'],
        gender: json['gender'],
        typeName: json['__typename'],
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'gender': gender, '__typename': typeName};
}

class JobHiring {
  final String? id;
  final String? typeName;

  JobHiring({this.id, this.typeName});

  factory JobHiring.fromJson(Map<String, dynamic> json) => JobHiring(
        id: json['id'],
        typeName: json['__typename'],
      );

  Map<String, dynamic> toJson() => {'id': id, '__typename': typeName};
}

class TalentEnquiries {
  String? id;
  String? talentId;
  String? enquiryDescription;
  String? enquiryFrom;
  String? createdAt;
  String? updatedAt;

  TalentEnquiries(
      {this.id,
      this.talentId,
      this.enquiryDescription,
      this.enquiryFrom,
      this.createdAt,
      this.updatedAt});

  TalentEnquiries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    talentId = json['talent_id'];
    enquiryDescription = json['enquiry_description'];
    enquiryFrom = json['enquiry_from'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['talent_id'] = this.talentId;
    data['enquiry_description'] = this.enquiryDescription;
    data['enquiry_from'] = this.enquiryFrom;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
