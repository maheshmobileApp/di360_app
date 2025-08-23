class GetMyTalentListingResp {
  TalentListingsProfile? data;

  GetMyTalentListingResp({this.data});

  GetMyTalentListingResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? TalentListingsProfile.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TalentListingsProfile {
  List<TalentListingDetails>? jobProfiles;

  TalentListingsProfile({this.jobProfiles});

TalentListingsProfile.fromJson(Map<String, dynamic> json) {
    if (json['job_profiles'] != null) {
      jobProfiles = <TalentListingDetails>[];
      json['job_profiles'].forEach((v) {
        jobProfiles!.add(TalentListingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobProfiles != null) {
      data['job_profiles'] = jobProfiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TalentListingDetails {
  String? id;
  String? created_at;
  String? updated_at;
  String? skills;
  String? jobexperiences;
  String? educations;
  String? upload_resume;
  String? job_designation;
  String? current_company;
  String? current_ctc;
  String? dental_professional_id;
  String? post_anonymously;
  String? admin_status;
  String? profile_image;
  String? full_name;
  String? mobile_number;
  String? email_address;
  String? work_type;
  String? profession_type;
  String? location;
  String? country;
  String? city;
  String? state;
  String? cover_letter;
  String? certificate;
  String? radius;
  String? abn_number;
  String? availabilityOption;
  String? availabilityDate;
  String? fromDate;
  String? availabilityDay;
  String? work_rights;
  String? Year_of_experiance;
  String? languages_spoken;
  String? areas_expertise;
  String? percentage;
  String? salary_amount;
  String? salary_type;
  String? aphra_number;
  String? willing_to_travel;
  String? travel_distance;
  String? about_yourself;
  String? availabilityType;
  String? unavailabilityDate;

  DentalProfessional? dentalProfessional;
  List<JobHiring>? jobhirings;

  TalentListingDetails();

  TalentListingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    skills = json['skills'];
    jobexperiences = json['jobexperiences'];
    educations = json['educations'];
    upload_resume = json['upload_resume'];
    job_designation = json['job_designation'];
    current_company = json['current_company'];
    current_ctc = json['current_ctc'];
    dental_professional_id = json['dental_professional_id'];
    post_anonymously = json['post_anonymously'];
    admin_status = json['admin_status'];
    profile_image = json['profile_image'];
    full_name = json['full_name'];
    mobile_number = json['mobile_number'];
    email_address = json['email_address'];
    work_type = json['work_type'];
    profession_type = json['profession_type'];
    location = json['location'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    cover_letter = json['cover_letter'];
    certificate = json['certificate'];
    radius = json['radius'];
    abn_number = json['abn_number'];
    availabilityOption = json['availabilityOption'];
    availabilityDate = json['availabilityDate'];
    fromDate = json['fromDate'];
    availabilityDay = json['availabilityDay'];
    work_rights = json['work_rights'];
    Year_of_experiance = json['Year_of_experiance'];
    languages_spoken = json['languages_spoken'];
    areas_expertise = json['areas_expertise'];
    percentage = json['percentage'];
    salary_amount = json['salary_amount'];
    salary_type = json['salary_type'];
    aphra_number = json['aphra_number'];
    willing_to_travel = json['willing_to_travel'];
    travel_distance = json['travel_distance'];
    about_yourself = json['about_yourself'];
    availabilityType = json['availabilityType'];
    unavailabilityDate = json['unavailabilityDate'];

    dentalProfessional = json['dental_professional'] != null
        ? DentalProfessional.fromJson(json['dental_professional'])
        : null;

    if (json['jobhirings'] != null) {
      jobhirings = <JobHiring>[];
      json['jobhirings'].forEach((v) {
        jobhirings!.add(JobHiring.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['skills'] = skills;
    data['jobexperiences'] = jobexperiences;
    data['educations'] = educations;
    data['upload_resume'] = upload_resume;
    data['job_designation'] = job_designation;
    data['current_company'] = current_company;
    data['current_ctc'] = current_ctc;
    data['dental_professional_id'] = dental_professional_id;
    data['post_anonymously'] = post_anonymously;
    data['admin_status'] = admin_status;
    data['profile_image'] = profile_image;
    data['full_name'] = full_name;
    data['mobile_number'] = mobile_number;
    data['email_address'] = email_address;
    data['work_type'] = work_type;
    data['profession_type'] = profession_type;
    data['location'] = location;
    data['country'] = country;
    data['city'] = city;
    data['state'] = state;
    data['cover_letter'] = cover_letter;
    data['certificate'] = certificate;
    data['radius'] = radius;
    data['abn_number'] = abn_number;
    data['availabilityOption'] = availabilityOption;
    data['availabilityDate'] = availabilityDate;
    data['fromDate'] = fromDate;
    data['availabilityDay'] = availabilityDay;
    data['work_rights'] = work_rights;
    data['Year_of_experiance'] = Year_of_experiance;
    data['languages_spoken'] = languages_spoken;
    data['areas_expertise'] = areas_expertise;
    data['percentage'] = percentage;
    data['salary_amount'] = salary_amount;
    data['salary_type'] = salary_type;
    data['aphra_number'] = aphra_number;
    data['willing_to_travel'] = willing_to_travel;
    data['travel_distance'] = travel_distance;
    data['about_yourself'] = about_yourself;
    data['availabilityType'] = availabilityType;
    data['unavailabilityDate'] = unavailabilityDate;

    if (dentalProfessional != null) {
      data['dental_professional'] = dentalProfessional!.toJson();
    }
    if (jobhirings != null) {
      data['jobhirings'] = jobhirings!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gender'] = gender;
    return data;
  }
}

class JobHiring {
  String? id;

  JobHiring({this.id});

  JobHiring.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
