class GetMyTalentListingData {
  List<JobProfiles>? jobProfiles;

  GetMyTalentListingData({this.jobProfiles});

  factory GetMyTalentListingData.fromJson(Map<String, dynamic> json) {
    return GetMyTalentListingData(
      jobProfiles: (json['job_profiles'] as List?)
          ?.whereType<Map<String, dynamic>>() // safety filter
          .map((v) => JobProfiles.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (jobProfiles != null) {
      data['job_profiles'] = jobProfiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class JobProfiles {
  String? id;
  String? adminStatus;
  String? activeStatus;
  String? currentCompany;
  String? createdAt;
  String? updatedAt;
  List<String>? skills;
  List<JobExperiences>? jobExperiences;
  String? jobDesignation;
  String? dentalProfessionalId;
  List<ProfileImage>? profileImage;
  String? fullName;
  List<String>? workType;
  String? professionType;
  String? location;
  String? country;
  String? city;
  String? state;
  List<dynamic>? fromDate; // keep dynamic to avoid Null.fromJson issue
  DentalProfessional? dentalProfessional;
  List<JobHirings>? jobHirings;
  String? sTypename;

  JobProfiles({
    this.id,
    this.adminStatus,
    this.activeStatus,
    this.currentCompany,
    this.createdAt,
    this.updatedAt,
    this.skills,
    this.jobExperiences,
    this.jobDesignation,
    this.dentalProfessionalId,
    this.profileImage,
    this.fullName,
    this.workType,
    this.professionType,
    this.location,
    this.country,
    this.city,
    this.state,
    this.fromDate,
    this.dentalProfessional,
    this.jobHirings,
    this.sTypename,
  });

  JobProfiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminStatus = json['admin_status'];
    activeStatus = json['active_status'];
    currentCompany = json['current_company'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    skills = (json['skills'] as List?)?.whereType<String>().toList();

    jobExperiences = (json['jobexperiences'] as List?)
        ?.whereType<Map<String, dynamic>>()
        .map((v) => JobExperiences.fromJson(v))
        .toList();

    jobDesignation = json['job_designation'];
    dentalProfessionalId = json['dental_professional_id'];

    profileImage = (json['profile_image'] as List?)
        ?.whereType<Map<String, dynamic>>()
        .map((v) => ProfileImage.fromJson(v))
        .toList();

    fullName = json['full_name'];
    workType = (json['work_type'] as List?)?.whereType<String>().toList();
    professionType = json['profession_type'];
    location = json['location'];
    country = json['country'];
    city = json['city'];
    state = json['state'];

    fromDate = (json['fromDate'] as List?) ?? [];

    dentalProfessional = json['dental_professional'] != null
        ? DentalProfessional.fromJson(
            json['dental_professional'] as Map<String, dynamic>)
        : null;

    jobHirings = (json['jobhirings'] as List?)
        ?.whereType<Map<String, dynamic>>()
        .map((v) => JobHirings.fromJson(v))
        .toList();

    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['admin_status'] = adminStatus;
    data['active_status'] = activeStatus;
    data['current_company'] = currentCompany;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['skills'] = skills;

    if (jobExperiences != null) {
      data['jobexperiences'] = jobExperiences!.map((v) => v.toJson()).toList();
    }

    data['job_designation'] = jobDesignation;
    data['dental_professional_id'] = dentalProfessionalId;

    if (profileImage != null) {
      data['profile_image'] = profileImage!.map((v) => v.toJson()).toList();
    }

    data['full_name'] = fullName;
    data['work_type'] = workType;
    data['profession_type'] = professionType;
    data['location'] = location;
    data['country'] = country;
    data['city'] = city;
    data['state'] = state;
    data['fromDate'] = fromDate;

    if (dentalProfessional != null) {
      data['dental_professional'] = dentalProfessional!.toJson();
    }

    if (jobHirings != null) {
      data['jobhirings'] = jobHirings!.map((v) => v.toJson()).toList();
    }

    data['__typename'] = sTypename;
    return data;
  }
}

class JobExperiences {
  String? ejobdesp;
  String? jobTitle;
  int? startYear;
  String? startMonth;
  bool? stillInRole;
  String? companyName;
  String? endYear;
  String? endMonth;

  JobExperiences({
    this.ejobdesp,
    this.jobTitle,
    this.startYear,
    this.startMonth,
    this.stillInRole,
    this.companyName,
    this.endYear,
    this.endMonth,
  });

  JobExperiences.fromJson(Map<String, dynamic> json) {
    ejobdesp = json['ejobdesp'];
    jobTitle = json['job_title'];
    startYear = json['startYear'];
    startMonth = json['startMonth'];
    stillInRole = json['stillInRole'];
    companyName = json['company_name'];
    endYear = json['endYear'];
    endMonth = json['endMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ejobdesp'] = ejobdesp;
    data['job_title'] = jobTitle;
    data['startYear'] = startYear;
    data['startMonth'] = startMonth;
    data['stillInRole'] = stillInRole;
    data['company_name'] = companyName;
    data['endYear'] = endYear;
    data['endMonth'] = endMonth;
    return data;
  }
}

class ProfileImage {
  String? url;
  String? name;
  String? type;
  String? extension;

  ProfileImage({this.url, this.name, this.type, this.extension});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    type = json['type'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['name'] = name;
    data['type'] = type;
    data['extension'] = extension;
    return data;
  }
}

class DentalProfessional {
  String? id;
  String? sTypename;

  DentalProfessional({this.id, this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['__typename'] = sTypename;
    return data;
  }
}

class JobHirings {
  String? id;
  String? sTypename;

  JobHirings({this.id, this.sTypename});

  JobHirings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['__typename'] = sTypename;
    return data;
  }
}
