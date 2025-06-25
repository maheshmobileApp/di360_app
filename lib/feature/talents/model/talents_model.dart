class GetTaltentModel {
  final TalentsData? data;

  GetTaltentModel({this.data});

  factory GetTaltentModel.fromJson(Map<String, dynamic> json) {
    return GetTaltentModel(
      data: json['data'] != null ? TalentsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class TalentsData {
  final List<JobProfile> jobProfiles;

  TalentsData({required this.jobProfiles});

  factory TalentsData.fromJson(Map<String, dynamic> json) {
    return TalentsData(
      jobProfiles: json['job_profiles'] != null
          ? (json['job_profiles'] as List)
              .map((item) => JobProfile.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_profiles': jobProfiles.map((profile) => profile.toJson()).toList(),
    };
  }
}

class JobProfile {
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
  final String? languagesSpoken;
  final String? areasExpertise;
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

  JobProfile({
    this.id,
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
    this.languagesSpoken,
    this.areasExpertise,
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
  });

  factory JobProfile.fromJson(Map<String, dynamic> json) {
    return JobProfile(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      jobExperiences: json['jobexperiences'] != null
          ? (json['jobexperiences'] as List)
              .map((item) => JobExperience.fromJson(item))
              .toList()
          : [],
      educations: json['educations'] != null
          ? (json['educations'] as List)
              .map((item) => Education.fromJson(item))
              .toList()
          : [],
      uploadResume: json['upload_resume'] != null
          ? (json['upload_resume'] as List)
              .map((item) => FileUpload.fromJson(item))
              .toList()
          : [],
      jobDesignation: json['job_designation'],
      currentCompany: json['current_company'],
      currentCtc: json['current_ctc'],
      dentalProfessionalId: json['dental_professional_id'],
      postAnonymously: json['post_anonymously'] ?? false,
      adminStatus: json['admin_status'],
      profileImage: json['profile_image'] != null
          ? (json['profile_image'] as List)
              .map((item) => FileUpload.fromJson(item))
              .toList()
          : [],
      fullName: json['full_name'],
      mobileNumber: json['mobile_number'],
      emailAddress: json['email_address'],
      workType:
          json['work_type'] != null ? List<String>.from(json['work_type']) : [],
      professionType: json['profession_type'],
      location: json['location'],
      country: json['country'],
      city: json['city'],
      state: json['state'],
      coverLetter: json['cover_letter'] != null
          ? (json['cover_letter'] as List)
              .map((item) => FileUpload.fromJson(item))
              .toList()
          : [],
      certificate: json['certificate'] != null
          ? (json['certificate'] as List)
              .map((item) => FileUpload.fromJson(item))
              .toList()
          : [],
      radius: json['radius'],
      abnNumber: json['abn_number'],
      availabilityOption: json['availabilityOption'],
      availabilityDate: json['availabilityDate'] != null
          ? List<String>.from(json['availabilityDate'])
          : [],
      fromDate:
          json['fromDate'] != null ? List<String>.from(json['fromDate']) : [],
      availabilityDay: json['availabilityDay'] != null
          ? List<String>.from(json['availabilityDay'])
          : [],
      workRights: json['work_rights'],
      yearOfExperience: json['Year_of_experiance'],
      languagesSpoken: json['languages_spoken'],
      areasExpertise: json['areas_expertise'],
      percentage: json['percentage'],
      salaryAmount: json['salary_amount'],
      salaryType: json['salary_type'],
      aphraNumber: json['aphra_number'],
      willingToTravel: json['willing_to_travel'] ?? false,
      travelDistance: json['travel_distance'],
      aboutYourself: json['about_yourself'],
      availabilityType: json['availabilityType'],
      unavailabilityDate: json['unavailabilityDate'] != null
          ? List<String>.from(json['unavailabilityDate'])
          : [],
      dentalProfessional: json['dental_professional'] != null
          ? DentalProfessional.fromJson(json['dental_professional'])
          : null,
      jobHirings: json['jobhirings'] != null
          ? (json['jobhirings'] as List)
              .map((item) => JobHiring.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'skills': skills,
      'jobexperiences': jobExperiences.map((exp) => exp.toJson()).toList(),
      'educations': educations.map((edu) => edu.toJson()).toList(),
      'upload_resume': uploadResume.map((file) => file.toJson()).toList(),
      'job_designation': jobDesignation,
      'current_company': currentCompany,
      'current_ctc': currentCtc,
      'dental_professional_id': dentalProfessionalId,
      'post_anonymously': postAnonymously,
      'admin_status': adminStatus,
      'profile_image': profileImage.map((img) => img.toJson()).toList(),
      'full_name': fullName,
      'mobile_number': mobileNumber,
      'email_address': emailAddress,
      'work_type': workType,
      'profession_type': professionType,
      'location': location,
      'country': country,
      'city': city,
      'state': state,
      'cover_letter': coverLetter.map((file) => file.toJson()).toList(),
      'certificate': certificate.map((cert) => cert.toJson()).toList(),
      'radius': radius,
      'abn_number': abnNumber,
      'availabilityOption': availabilityOption,
      'availabilityDate': availabilityDate,
      'fromDate': fromDate,
      'availabilityDay': availabilityDay,
      'work_rights': workRights,
      'Year_of_experiance': yearOfExperience,
      'languages_spoken': languagesSpoken,
      'areas_expertise': areasExpertise,
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
      'jobhirings': jobHirings.map((hiring) => hiring.toJson()).toList(),
    };
  }
}

class JobExperience {
  final int? endYear;
  final String? jobDescription;
  final String? endMonth;
  final String? jobTitle;
  final int? startYear;
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

  factory JobExperience.fromJson(Map<String, dynamic> json) {
    return JobExperience(
      endYear: json['endYear'],
      jobDescription: json['ejobdesp'],
      endMonth: json['endMonth'],
      jobTitle: json['job_title'],
      startYear: json['startYear'],
      startMonth: json['startMonth'],
      stillInRole: json['stillInRole'],
      companyName: json['company_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
}

class Education {
  final String? finishDate;
  final String? institution;
  final String? qualification;
  final String? courseHighlights;
  final bool? qualificationFinished;

  Education({
    this.finishDate,
    this.institution,
    this.qualification,
    this.courseHighlights,
    this.qualificationFinished,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      finishDate: json['finishDate'],
      institution: json['institution'],
      qualification: json['qualification'],
      courseHighlights: json['courseHighlights'],
      qualificationFinished: json['qualificationFinished'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'finishDate': finishDate,
      'institution': institution,
      'qualification': qualification,
      'courseHighlights': courseHighlights,
      'qualificationFinished': qualificationFinished,
    };
  }
}

class FileUpload {
  final String? url;
  final String? name;
  final String? type;
  final String? extension;

  FileUpload({
    this.url,
    this.name,
    this.type,
    this.extension,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) {
    return FileUpload(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      extension: json['extension'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'type': type,
      'extension': extension,
    };
  }
}

class DentalProfessional {
  final String? id;
  final String? gender;
  final String? typeName;

  DentalProfessional({
    this.id,
    this.gender,
    this.typeName,
  });

  factory DentalProfessional.fromJson(Map<String, dynamic> json) {
    return DentalProfessional(
      id: json['id'],
      gender: json['gender'],
      typeName: json['__typename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gender': gender,
      '__typename': typeName,
    };
  }
}

class JobHiring {
  final String? id;
  final String? typeName;

  JobHiring({
    this.id,
    this.typeName,
  });

  factory JobHiring.fromJson(Map<String, dynamic> json) {
    return JobHiring(
      id: json['id'],
      typeName: json['__typename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      '__typename': typeName,
    };
  }
}
