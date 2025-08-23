class GetMyTalentListingResp {
  GetMyTalentListingData? data;

  GetMyTalentListingResp({this.data});

  GetMyTalentListingResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? GetMyTalentListingData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetMyTalentListingData {
  List<TalentListingProfiles>? jobProfiles;

  GetMyTalentListingData({this.jobProfiles});

  GetMyTalentListingData.fromJson(Map<String, dynamic> json) {
    if (json['job_profiles'] != null) {
      jobProfiles = <TalentListingProfiles>[];
      json['job_profiles'].forEach((v) {
        jobProfiles!.add(TalentListingProfiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (jobProfiles != null) {
      data['job_profiles'] = jobProfiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TalentListingProfiles {
  String? id;
  String? createdAt;
  String? updatedAt;
  dynamic skills;
  List<dynamic>? jobexperiences;
  List<dynamic>? educations;
  List<dynamic>? uploadResume;
  dynamic jobDesignation;
  dynamic currentCompany;
  String? currentCtc;
  String? dentalProfessionalId;
  bool? postAnonymously;
  String? adminStatus;
  List<dynamic>? profileImage;
  String? fullName;
  String? mobileNumber;
  String? emailAddress;
  dynamic workType;
  dynamic professionType;
  dynamic location;
  dynamic country;
  dynamic city;
  dynamic state;
  List<dynamic>? coverLetter;
  List<dynamic>? certificate;
  dynamic radius;
  dynamic abnNumber;
  String? availabilityOption;
  List<dynamic>? availabilityDate;
  List<dynamic>? fromDate;
  List<dynamic>? availabilityDay;
  dynamic workRights;
  dynamic yearOfExperiance;
  dynamic languagesSpoken;
  dynamic areasExpertise;
  dynamic percentage;
  dynamic salaryAmount;
  dynamic salaryType;
  dynamic aphraNumber;
  bool? willingToTravel;
  dynamic travelDistance;
  dynamic aboutYourself;
  String? availabilityType;
  List<dynamic>? unavailabilityDate;
  DentalProfessional? dentalProfessional;
  List<dynamic>? jobhirings;

  TalentListingProfiles({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.skills,
    this.jobexperiences,
    this.educations,
    this.uploadResume,
    this.jobDesignation,
    this.currentCompany,
    this.currentCtc,
    this.dentalProfessionalId,
    this.postAnonymously,
    this.adminStatus,
    this.profileImage,
    this.fullName,
    this.mobileNumber,
    this.emailAddress,
    this.workType,
    this.professionType,
    this.location,
    this.country,
    this.city,
    this.state,
    this.coverLetter,
    this.certificate,
    this.radius,
    this.abnNumber,
    this.availabilityOption,
    this.availabilityDate,
    this.fromDate,
    this.availabilityDay,
    this.workRights,
    this.yearOfExperiance,
    this.languagesSpoken,
    this.areasExpertise,
    this.percentage,
    this.salaryAmount,
    this.salaryType,
    this.aphraNumber,
    this.willingToTravel,
    this.travelDistance,
    this.aboutYourself,
    this.availabilityType,
    this.unavailabilityDate,
    this.dentalProfessional,
    this.jobhirings,
  });

  TalentListingProfiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    skills = json['skills'];
    jobexperiences = json['jobexperiences'] ?? [];
    educations = json['educations'] ?? [];
    uploadResume = json['upload_resume'] ?? [];
    jobDesignation = json['job_designation'];
    currentCompany = json['current_company'];
    currentCtc = json['current_ctc'];
    dentalProfessionalId = json['dental_professional_id'];
    postAnonymously = json['post_anonymously'];
    adminStatus = json['admin_status'];
    profileImage = json['profile_image'] ?? [];
    fullName = json['full_name'];
    mobileNumber = json['mobile_number'];
    emailAddress = json['email_address'];
    workType = json['work_type'];
    professionType = json['profession_type'];
    location = json['location'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    coverLetter = json['cover_letter'] ?? [];
    certificate = json['certificate'] ?? [];
    radius = json['radius'];
    abnNumber = json['abn_number'];
    availabilityOption = json['availabilityOption'];
    availabilityDate = json['availabilityDate'] ?? [];
    fromDate = json['fromDate'] ?? [];
    availabilityDay = json['availabilityDay'] ?? [];
    workRights = json['work_rights'];
    yearOfExperiance = json['Year_of_experiance'];
    languagesSpoken = json['languages_spoken'];
    areasExpertise = json['areas_expertise'];
    percentage = json['percentage'];
    salaryAmount = json['salary_amount'];
    salaryType = json['salary_type'];
    aphraNumber = json['aphra_number'];
    willingToTravel = json['willing_to_travel'];
    travelDistance = json['travel_distance'];
    aboutYourself = json['about_yourself'];
    availabilityType = json['availabilityType'];
    unavailabilityDate = json['unavailabilityDate'] ?? [];
    dentalProfessional = json['dental_professional'] != null
        ? DentalProfessional.fromJson(json['dental_professional'])
        : null;
    jobhirings = json['jobhirings'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['skills'] = skills;
    data['jobexperiences'] = jobexperiences;
    data['educations'] = educations;
    data['upload_resume'] = uploadResume;
    data['job_designation'] = jobDesignation;
    data['current_company'] = currentCompany;
    data['current_ctc'] = currentCtc;
    data['dental_professional_id'] = dentalProfessionalId;
    data['post_anonymously'] = postAnonymously;
    data['admin_status'] = adminStatus;
    data['profile_image'] = profileImage;
    data['full_name'] = fullName;
    data['mobile_number'] = mobileNumber;
    data['email_address'] = emailAddress;
    data['work_type'] = workType;
    data['profession_type'] = professionType;
    data['location'] = location;
    data['country'] = country;
    data['city'] = city;
    data['state'] = state;
    data['cover_letter'] = coverLetter;
    data['certificate'] = certificate;
    data['radius'] = radius;
    data['abn_number'] = abnNumber;
    data['availabilityOption'] = availabilityOption;
    data['availabilityDate'] = availabilityDate;
    data['fromDate'] = fromDate;
    data['availabilityDay'] = availabilityDay;
    data['work_rights'] = workRights;
    data['Year_of_experiance'] = yearOfExperiance;
    data['languages_spoken'] = languagesSpoken;
    data['areas_expertise'] = areasExpertise;
    data['percentage'] = percentage;
    data['salary_amount'] = salaryAmount;
    data['salary_type'] = salaryType;
    data['aphra_number'] = aphraNumber;
    data['willing_to_travel'] = willingToTravel;
    data['travel_distance'] = travelDistance;
    data['about_yourself'] = aboutYourself;
    data['availabilityType'] = availabilityType;
    data['unavailabilityDate'] = unavailabilityDate;
    data['jobhirings'] = jobhirings;
    if (dentalProfessional != null) {
      data['dental_professional'] = dentalProfessional!.toJson();
    }
    return data;
  }
}

class DentalProfessional {
  String? id;
  String? gender;

  DentalProfessional({this.id, this.gender});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['gender'] = gender;
    return data;
  }
}
