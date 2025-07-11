class GetJobSeekFilterRes {
  JobSeekFilterData? data;

  GetJobSeekFilterRes({this.data});

  GetJobSeekFilterRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? JobSeekFilterData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class JobSeekFilterData {
  List<JobSeekFilterResponse>? jobs;

  JobSeekFilterData({this.jobs});

  JobSeekFilterData.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <JobSeekFilterResponse>[];
      json['jobs'].forEach((v) {
        jobs!.add(JobSeekFilterResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobSeekFilterResponse {
  String? id;
  String? title;
  String? jType;
  String? jRole;
  String? description;
  Map<String, dynamic>? typeofEmployment;
  String? yearsOfExperience;
  Map<String, dynamic>? availabilityDate;
  String? dentalPracticeId;
  String? dentalSupplierId;
  String? activeStatus;
  String? location;
  String? logo;
  String? state;
  String? city;
  String? salary;
  String? companyName;
  String? websiteUrl;
  String? payRange;
  String? education;
  String? video;
  String? closedAt;
  String? status;
  List<dynamic>? offeredBenefits;
  String? country;
  bool? endDateToggle;
  String? payMax;
  String? payMin;
  String? hiringPeriod;
  int? noOfPeople;
  String? rateBilling;
  String? linkedinUrl;
  String? instagramUrl;
  String? facebookUrl;
  String? clinicLogo;
  String? timings;
  String? bannerImage;
  bool? timingToggle;
  String? createdAt;
  int? applicantCount;

  JobSeekFilterResponse({
    this.id,
    this.title,
    this.jType,
    this.jRole,
    this.description,
    this.typeofEmployment,
    this.yearsOfExperience,
    this.availabilityDate,
    this.dentalPracticeId,
    this.dentalSupplierId,
    this.activeStatus,
    this.location,
    this.logo,
    this.state,
    this.city,
    this.salary,
    this.companyName,
    this.websiteUrl,
    this.payRange,
    this.education,
    this.video,
    this.closedAt,
    this.status,
    this.offeredBenefits,
    this.country,
    this.endDateToggle,
    this.payMax,
    this.payMin,
    this.hiringPeriod,
    this.noOfPeople,
    this.rateBilling,
    this.linkedinUrl,
    this.instagramUrl,
    this.facebookUrl,
    this.clinicLogo,
    this.timings,
    this.bannerImage,
    this.timingToggle,
    this.createdAt,
    this.applicantCount,
  });

  JobSeekFilterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    jType = json['j_type'];
    jRole = json['j_role'];
    description = json['description'];
    typeofEmployment = json['TypeofEmployment'];
    yearsOfExperience = json['years_of_experience'];
    availabilityDate = json['availability_date'];
    dentalPracticeId = json['dental_practice_id'];
    dentalSupplierId = json['dental_supplier_id'];
    activeStatus = json['active_status'];
    location = json['location'];
    logo = json['logo'];
    state = json['state'];
    city = json['city'];
    salary = json['salary'];
    companyName = json['company_name'];
    websiteUrl = json['website_url'];
    payRange = json['pay_range'];
    education = json['education'];
    video = json['video'];
    closedAt = json['closed_at'];
    status = json['status'];
    offeredBenefits = json['offered_benefits'];
    country = json['country'];
    endDateToggle = json['endDateToggle'];
    payMax = json['pay_max'];
    payMin = json['pay_min'];
    hiringPeriod = json['hiring_period'];
    noOfPeople = json['no_of_people'];
    rateBilling = json['rate_billing'];
    linkedinUrl = json['linkedin_url'];
    instagramUrl = json['instagram_url'];
    facebookUrl = json['facebook_url'];
    clinicLogo = json['clinic_logo'];
    timings = json['timings'];
    bannerImage = json['banner_image'];
    timingToggle = json['timingtoggle'];
    createdAt = json['created_at'];
    applicantCount = json['job_applicants_aggregate']?['aggregate']?['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['title'] = this.title;
    data['j_type'] = this.jType;
    data['j_role'] = this.jRole;
    data['description'] = this.description;
    data['TypeofEmployment'] = this.typeofEmployment;
    data['years_of_experience'] = this.yearsOfExperience;
    data['availability_date'] = this.availabilityDate;
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['active_status'] = this.activeStatus;
    data['location'] = this.location;
    data['logo'] = this.logo;
    data['state'] = this.state;
    data['city'] = this.city;
    data['salary'] = this.salary;
    data['company_name'] = this.companyName;
    data['website_url'] = this.websiteUrl;
    data['pay_range'] = this.payRange;
    data['education'] = this.education;
    data['video'] = this.video;
    data['closed_at'] = this.closedAt;
    data['status'] = this.status;
    data['offered_benefits'] = this.offeredBenefits;
    data['country'] = this.country;
    data['endDateToggle'] = this.endDateToggle;
    data['pay_max'] = this.payMax;
    data['pay_min'] = this.payMin;
    data['hiring_period'] = this.hiringPeriod;
    data['no_of_people'] = this.noOfPeople;
    data['rate_billing'] = this.rateBilling;
    data['linkedin_url'] = this.linkedinUrl;
    data['instagram_url'] = this.instagramUrl;
    data['facebook_url'] = this.facebookUrl;
    data['clinic_logo'] = this.clinicLogo;
    data['timings'] = this.timings;
    data['banner_image'] = this.bannerImage;
    data['timingtoggle'] = this.timingToggle;
    data['created_at'] = this.createdAt;
    data['job_applicants_aggregate'] = {
      'aggregate': {'count': this.applicantCount}
    };
    return data;
  }
}
