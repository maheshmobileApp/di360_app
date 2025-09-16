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

  static List<String> _normalizeList(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    } else if (value is String && value.isNotEmpty) {
      return [value];
    }
    return [];
  }

  factory JobProfile.fromJson(Map<String, dynamic> json) => JobProfile(
        id: json['id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        skills: (json['skills'] as List?)?.map((e) => e.toString()).toList(),
        jobExperiences: (json['job_experiences'] as List? ?? [])
            .map((e) => JobExperience.fromJson(e))
            .toList(),
        educations: (json['educations'] as List? ?? [])
            .map((e) => Education.fromJson(e))
            .toList(),
        uploadResume: (json['upload_resume'] as List? ?? [])
            .map((e) => FileUpload.fromJson(e))
            .toList(),
        jobDesignation: json['job_designation'],
        currentCompany: json['current_company'],
        currentCtc: json['current_ctc'],
        dentalProfessionalId: json['dental_professional_id'],
        postAnonymously: json['post_anonymously'] ?? false,
        adminStatus: json['admin_status'],
        activeStatus: json['active_status'],
        profileImage: (json['profile_image'] as List? ?? [])
            .map((e) => FileUpload.fromJson(e))
            .toList(),
        fullName: json['full_name'],
        mobileNumber: json['mobile_number'],
        emailAddress: json['email_address'],
        workType: _normalizeList(json['work_type']),
        professionType: json['profession_type'],
        location: json['location'],
        country: json['country'],
        city: json['city'],
        state: json['state'],
        coverLetter: (json['cover_letter'] as List? ?? [])
            .map((e) => FileUpload.fromJson(e))
            .toList(),
        certificate: (json['certificate'] as List? ?? [])
            .map((e) => FileUpload.fromJson(e))
            .toList(),
        radius: json['radius'],
        abnNumber: json['abn_number'],
        availabilityOption: json['availabilityOption'],
        availabilityDate: _normalizeList(json['availabilityDate']),
        fromDate: _normalizeList(json['fromDate']),
        availabilityDay: _normalizeList(json['availabilityDay']),
        workRights: json['work_rights'],
        yearOfExperience: json['year_of_experience'],
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
        unavailabilityDate: _normalizeList(json['unavailabilityDate']),
        dentalProfessional: json['dental_professional'] != null
            ? DentalProfessional.fromJson(json['dental_professional'])
            : null,
        jobHirings: (json['jobhirings'] as List? ?? [])
            .map((e) => JobHiring.fromJson(e))
            .toList(),
      );

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
        'year_of_experience': yearOfExperience,
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
        'jobhirings': jobHirings.map((e) => e.toJson()).toList(),
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
    bool? qualificationFinished;
    if (json['qualificationFinished'] is bool) {
      qualificationFinished = json['qualificationFinished'];
    } else if (json['qualificationFinished'] is String) {
      qualificationFinished =
          json['qualificationFinished'].toLowerCase() == 'true';
    }
    return Education(
      finishDate: json['finishDate'],
      institution: json['institution'],
      qualification: json['qualification'],
      courseHighlights: json['courseHighlights'],
      qualificationFinished: qualificationFinished,
    );
  }

  Map<String, dynamic> toJson() => {
        'finishDate': finishDate,
        'institution': institution,
        'qualification': qualification,
        'courseHighlights': courseHighlights,
        'qualificationFinished': qualificationFinished,
      };
}

class FileUpload {
  final String url;
  final String name;
  final String type;
  final String extension;

  FileUpload({
    required this.url,
    required this.name,
    required this.type,
    required this.extension,
  });

  factory FileUpload.fromJson(Map<String, dynamic> json) => FileUpload(
        url: json['url'] ?? '',
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        extension: json['extension'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
        'type': type,
        'extension': extension,
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
