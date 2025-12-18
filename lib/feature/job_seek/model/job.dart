//import 'package:di360_flutter/feature/job_seek/model/job_model.dart';

//import 'package:di360_flutter/feature/directors/model_class/get_directories_details_res.dart';

class Jobs {
  String? id;
  String? title;
  String? jType;
  String? jRole;
  String? description;
  List<String>? typeofEmployment;
  List<String>? availabilityDate;
  String? autoExpiryDate;
  String? yearsOfExperience;
  dynamic dentalPracticeId;
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
  List<String>? offeredBenefits;
  String? country;
  String? endDateToggle;
  int? payMax;
  int? payMin;
  String? hiringPeriod;
  String? noOfPeople;
  String? rateBilling;
  String? linkedinUrl;
  String? instagramUrl;
  String? facebookUrl;
  List<ClinicLogo>? clinicLogo;
  String? timings;
  ClinicLogo? bannerImage;
  String? timingtoggle;
  String? createdAt;
  String? updatedAt;
  JobApplicantsAggregate? jobApplicantsAggregate;
  

  Jobs(
      {this.id,
      this.title,
      this.jType,
      this.jRole,
      this.description,
      this.typeofEmployment,
      this.availabilityDate,
      this.autoExpiryDate,
      this.yearsOfExperience,
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
      this.timingtoggle,
      this.createdAt,
      this.updatedAt,
      this.jobApplicantsAggregate});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    jType = json['j_type'];
    jRole = json['j_role'];
    description = json['description'];

    typeofEmployment = json['TypeofEmployment'] is List
        ? List<String>.from(json['TypeofEmployment'])
        : [];

    availabilityDate = json['availability_date'] is List
        ? List<String>.from(json['availability_date'])
        : [];

    autoExpiryDate = json['auto_expiry_date']?.toString();
    yearsOfExperience = json['years_of_experience']?.toString();
    dentalPracticeId = json['dental_practice_id'];
    dentalSupplierId = json['dental_supplier_id'];
    activeStatus = json['active_status'];
    location = json['location'];
    logo = json['logo']?.toString();
    state = json['state'];
    city = json['city'];
    salary = json['salary'];
    companyName = json['company_name'];
    websiteUrl = json['website_url'];
    payRange = json['pay_range'];
    education = json['education'];
    video = json['video']?.toString();
    closedAt = json['closed_at'];
    status = json['status'];

    offeredBenefits = json['offered_benefits'] is List
        ? List<String>.from(json['offered_benefits'])
        : [];

    country = json['country'];
    endDateToggle = json['endDateToggle'];
    payMax = json['pay_max'];
    payMin = json['pay_min'];
    hiringPeriod = json['hiring_period'];
    noOfPeople = json['no_of_people']?.toString();
    rateBilling = json['rate_billing'];
    linkedinUrl = json['linkedin_url'] ?? "";
    instagramUrl = json['instagram_url'] ?? "";
    facebookUrl = json['facebook_url'] ?? "";

    if (json['clinic_logo'] != null) {
      if (json['clinic_logo'] is List) {
        clinicLogo = (json['clinic_logo'] as List)
            .map((e) => ClinicLogo.fromJson(e))
            .toList();
      } else if (json['clinic_logo'] is String) {
        clinicLogo = [ClinicLogo(url: json['clinic_logo'])];
      }
    } else {
      clinicLogo = null;
    }

    if (json['banner_image'] != null) {
      if (json['banner_image'] is Map) {
        bannerImage = ClinicLogo.fromJson(json['banner_image']);
      } else if (json['banner_image'] is String) {
        bannerImage = ClinicLogo(url: json['banner_image']);
      } else {
        bannerImage = null;
      }
    } else {
      bannerImage = null;
    }
    timings = json['timings'];
    timingtoggle = json['timingtoggle'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    jobApplicantsAggregate = json['job_applicants_aggregate'] != null
        ? JobApplicantsAggregate.fromJson(json['job_applicants_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['j_type'] = this.jType;
    data['j_role'] = this.jRole;
    data['description'] = this.description;
    data['TypeofEmployment'] = this.typeofEmployment;
    data['availability_date'] = this.availabilityDate;
    data['auto_expiry_date'] = this.autoExpiryDate;
    data['years_of_experience'] = this.yearsOfExperience;
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
    if (this.clinicLogo != null) {
      data['clinic_logo'] = this.clinicLogo!.map((v) => v.toJson()).toList();
    }
    data['timings'] = this.timings;
    data['banner_image'] = this.bannerImage;
    data['timingtoggle'] = this.timingtoggle;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.jobApplicantsAggregate != null) {
      data['job_applicants_aggregate'] = this.jobApplicantsAggregate!.toJson();
    }
    return data;
  }
}

class ClinicLogo {
  String? url;
  String? type;
  String? extension;

  ClinicLogo({this.url, this.type, this.extension});

  ClinicLogo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    data['extension'] = this.extension;
    return data;
  }
}

class Banner {
  String? url;
  String? type;
  String? extension;

  Banner({this.url, this.type, this.extension});

  Banner.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    data['extension'] = this.extension;
    return data;
  }
}

class JobApplicantsAggregate {
  Aggregate? aggregate;

  JobApplicantsAggregate({this.aggregate});

  JobApplicantsAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
