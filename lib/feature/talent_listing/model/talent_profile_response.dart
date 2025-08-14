class TalentProfileResponse {
  final List<TalentProfile> jobProfiles;

 TalentProfileResponse({required this.jobProfiles});

  factory TalentProfileResponse.fromJson(Map<String, dynamic> json) {
    return TalentProfileResponse(
      jobProfiles: (json['data']['job_profiles'] as List)
          .map((e) =>  TalentProfile.fromJson(e))
          .toList(),
    );
  }
}

class TalentProfile {
  final String id;
  final String createdAt;
  final String updatedAt;
  final List<String>? skills;
  final List<JobExperience> jobExperiences;
  final List<Education> educations;
  final List<Resume> uploadResume;
  final String jobDesignation;
  final String currentCompany;
  final String currentCtc;
  final String dentalProfessionalId;
  final bool postAnonymously;
  final String adminStatus;
  final List<ProfileImage> profileImage;
  final String fullName;
  final String mobileNumber;
  final String emailAddress;
  final List<String> workType;
  final String professionType;
  final String location;
  final String country;
  final String city;
  final String state;
  final List<CoverLetter> coverLetter;
  final List<Certificate> certificate;
  final String radius;
  final String? abnNumber;
  final String availabilityOption;
  final List<dynamic> availabilityDate;
  final List<dynamic> fromDate;
  final List<String> availabilityDay;
  final String workRights;
  final String yearOfExperience;
  final String languagesSpoken;
  final String? areasExpertise;
  final String? percentage;
  final num salaryAmount;
  final String salaryType;
  final String aphraNumber;
  final bool willingToTravel;
  final String? travelDistance;
  final String? aboutYourself;
  final String availabilityType;
  final List<dynamic> unavailabilityDate;
  final DentalProfessional dentalProfessional;
  final List<dynamic> jobhirings;

  TalentProfile({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.skills,
    required this.jobExperiences,
    required this.educations,
    required this.uploadResume,
    required this.jobDesignation,
    required this.currentCompany,
    required this.currentCtc,
    required this.dentalProfessionalId,
    required this.postAnonymously,
    required this.adminStatus,
    required this.profileImage,
    required this.fullName,
    required this.mobileNumber,
    required this.emailAddress,
    required this.workType,
    required this.professionType,
    required this.location,
    required this.country,
    required this.city,
    required this.state,
    required this.coverLetter,
    required this.certificate,
    required this.radius,
    this.abnNumber,
    required this.availabilityOption,
    required this.availabilityDate,
    required this.fromDate,
    required this.availabilityDay,
    required this.workRights,
    required this.yearOfExperience,
    required this.languagesSpoken,
    this.areasExpertise,
    this.percentage,
    required this.salaryAmount,
    required this.salaryType,
    required this.aphraNumber,
    required this.willingToTravel,
    this.travelDistance,
    this.aboutYourself,
    required this.availabilityType,
    required this.unavailabilityDate,
    required this.dentalProfessional,
    required this.jobhirings,
  });

  factory TalentProfile.fromJson(Map<String, dynamic> json) {
    return  TalentProfile(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      skills: (json['skills'] as List?)?.map((e) => e.toString()).toList(),
      jobExperiences: (json['jobexperiences'] as List)
          .map((e) => JobExperience.fromJson(e))
          .toList(),
      educations: (json['educations'] as List)
          .map((e) => Education.fromJson(e))
          .toList(),
      uploadResume: (json['upload_resume'] as List)
          .map((e) => Resume.fromJson(e))
          .toList(),
      jobDesignation: json['job_designation'],
      currentCompany: json['current_company'],
      currentCtc: json['current_ctc'],
      dentalProfessionalId: json['dental_professional_id'],
      postAnonymously: json['post_anonymously'],
      adminStatus: json['admin_status'],
      profileImage: (json['profile_image'] as List)
          .map((e) => ProfileImage.fromJson(e))
          .toList(),
      fullName: json['full_name'],
      mobileNumber: json['mobile_number'],
      emailAddress: json['email_address'],
      workType: List<String>.from(json['work_type']),
      professionType: json['profession_type'],
      location: json['location'],
      country: json['country'],
      city: json['city'],
      state: json['state'],
      coverLetter: (json['cover_letter'] as List)
          .map((e) => CoverLetter.fromJson(e))
          .toList(),
      certificate: (json['certificate'] as List)
          .map((e) => Certificate.fromJson(e))
          .toList(),
      radius: json['radius'],
      abnNumber: json['abn_number'],
      availabilityOption: json['availabilityOption'],
      availabilityDate: json['availabilityDate'],
      fromDate: json['fromDate'],
      availabilityDay: List<String>.from(json['availabilityDay']),
      workRights: json['work_rights'],
      yearOfExperience: json['Year_of_experiance'],
      languagesSpoken: json['languages_spoken'],
      areasExpertise: json['areas_expertise'],
      percentage: json['percentage']?.toString(),
      salaryAmount: json['salary_amount'],
      salaryType: json['salary_type'],
      aphraNumber: json['aphra_number'],
      willingToTravel: json['willing_to_travel'],
      travelDistance: json['travel_distance']?.toString(),
      aboutYourself: json['about_yourself'],
      availabilityType: json['availabilityType'],
      unavailabilityDate: json['unavailabilityDate'],
      dentalProfessional:
          DentalProfessional.fromJson(json['dental_professional']),
      jobhirings: json['jobhirings'] ?? [],
    );
  }
}

class JobExperience {
  final String jobTitle;
  final String companyName;
  final int startYear;
  final String startMonth;
  final String? endYear;
  final String? endMonth;
  final bool stillInRole;
  final String ejobdesp;

  JobExperience({
    required this.jobTitle,
    required this.companyName,
    required this.startYear,
    required this.startMonth,
    this.endYear,
    this.endMonth,
    required this.stillInRole,
    required this.ejobdesp,
  });

  factory JobExperience.fromJson(Map<String, dynamic> json) {
    return JobExperience(
      jobTitle: json['job_title'],
      companyName: json['company_name'],
      startYear: json['startYear'],
      startMonth: json['startMonth'],
      endYear: json['endYear'] == "" ? null : json['endYear'],
      endMonth: json['endMonth'] == "" ? null : json['endMonth'],
      stillInRole: json['stillInRole'],
      ejobdesp: json['ejobdesp'],
    );
  }
}

class Education {
  final String finishDate;
  final String institution;
  final String qualification;
  final String courseHighlights;
  final bool qualificationFinished;

  Education({
    required this.finishDate,
    required this.institution,
    required this.qualification,
    required this.courseHighlights,
    required this.qualificationFinished,
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
}

class Resume {
  final String url;
  final String name;
  final String type;
  final String extension;

  Resume({
    required this.url,
    required this.name,
    required this.type,
    required this.extension,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      extension: json['extension'],
    );
  }
}

class ProfileImage {
  final String url;
  final String name;
  final String type;
  final String extension;

  ProfileImage({
    required this.url,
    required this.name,
    required this.type,
    required this.extension,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      extension: json['extension'],
    );
  }
}

class CoverLetter {
  final String url;
  final String name;
  final String type;
  final String extension;

  CoverLetter({
    required this.url,
    required this.name,
    required this.type,
    required this.extension,
  });

  factory CoverLetter.fromJson(Map<String, dynamic> json) {
    return CoverLetter(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      extension: json['extension'],
    );
  }
}

class Certificate {
  final String url;
  final String name;
  final String type;
  final String extension;

  Certificate({
    required this.url,
    required this.name,
    required this.type,
    required this.extension,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      extension: json['extension'],
    );
  }
}

class DentalProfessional {
  final String id;
  final String? gender;

  DentalProfessional({required this.id, this.gender});

  factory DentalProfessional.fromJson(Map<String, dynamic> json) {
    return DentalProfessional(
      id: json['id'],
      gender: json['gender'],
    );
  }
}
