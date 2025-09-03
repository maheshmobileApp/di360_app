import 'package:di360_flutter/feature/job_seek/model/job_model.dart';

class Jobs {
  String? id;
  String? title;
  String? jType;
  String? jRole;
  String? description;
  List<String>? typeofEmployment;
  String? yearsOfExperience;
  String? dentalPracticeId;
  String? dentalSupplierId;
  String? location;
  String? logo;
  String? state;
  String? city;
  String? companyName;
  String? salary;
  String? websiteUrl;
  String? payRange;
  String? education;
  String? video;
  String? rateBilling;
  String? createdAt;
  JobApplicantsAggregate? jobApplicantsAggregate;
  String? country;
  dynamic daysOfWeek;
  dynamic currentCompany;
  String? endDateToggle;
  dynamic experience;
  String? facebookUrl;
  String? hiringPeriod;
  String? instagramUrl;
  bool? isFeatured;
  dynamic closingMessage;
  String? closedAt;
  List<ClinicLogo>? clinicLogo;
  String? bannerImage;
  List<String>? availabilityDate;
  dynamic address;
  String? activeStatus;
  int? payMin;
  int? payMax;
  List<JobEnquiry>? jobEnquiries;
  String? status;


  Jobs({
    this.id,
    this.title,
    this.jType,
    this.jRole,
    this.description,
    this.typeofEmployment,
    this.yearsOfExperience,
    this.dentalPracticeId,
    this.dentalSupplierId,
    this.location,
    this.logo,
    this.state,
    this.city,
    this.companyName,
    this.salary,
    this.websiteUrl,
    this.payRange,
    this.education,
    this.video,
    this.rateBilling,
    this.createdAt,
    this.jobApplicantsAggregate,
    this.country,
    this.daysOfWeek,
    this.currentCompany,
    this.endDateToggle,
    this.experience,
    this.facebookUrl,
    this.hiringPeriod,
    this.instagramUrl,
    this.isFeatured,
    this.closingMessage,
    this.closedAt,
    this.clinicLogo,
    this.bannerImage,
    this.availabilityDate,
    this.address,
    this.activeStatus,
    this.payMin,
    this.payMax,
    this.jobEnquiries,
    this.status,
  });

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    jType = json['j_type'];
    jRole = json['j_role'];
    description = json['description'];

    // Safe cast of list of strings
    typeofEmployment = (json['TypeofEmployment'] is List)
        ? List<String>.from(json['TypeofEmployment'].map((e) => e.toString()))
        : [];

    yearsOfExperience = json['years_of_experience'];
    dentalPracticeId = json['dental_practice_id'];
    dentalSupplierId = json['dental_supplier_id'];
    location = json['location'];
    logo = json['logo'];
    state = json['state'];
    city = json['city'];
    companyName = json['company_name'];
    salary = json['salary'];
    websiteUrl = json['website_url'];
    payRange = json['pay_range'];
    education = json['education'];
    video = json['video'];
    rateBilling = json['rate_billing'];
    createdAt = json['created_at'];

    jobApplicantsAggregate = json['job_applicants_aggregate'] != null
        ? JobApplicantsAggregate.fromJson(json['job_applicants_aggregate'])
        : null;

    country = json['country'];
    daysOfWeek = json['days_of_week'];
    currentCompany = json['current_company'];
    endDateToggle = json['endDateToggle'];
    experience = json['experience'];
    facebookUrl = json['facebook_url'] ?? '';
    hiringPeriod = json['hiring_period'];
    instagramUrl = json['instagram_url'] ?? '';
    isFeatured = json['is_featured'];
    closingMessage = json['closing_message'];
    closedAt = json['closed_at'];

    clinicLogo = (json['clinic_logo'] is List)
        ? (json['clinic_logo'] as List)
            .map((v) => ClinicLogo.fromJson(v))
            .toList()
        : [];

    bannerImage = json['banner_image'];

    availabilityDate = (json['availability_date'] is List)
        ? List<String>.from(json['availability_date'].map((e) => e.toString()))
        : [];

    address = json['address'];
    activeStatus = json['active_status'];
    payMin = json['pay_min'];
    payMax = json['pay_max'];
    jobEnquiries = (json['job_enquiries'] is List)
        ? (json['job_enquiries'] as List)
            .map((v) => JobEnquiry.fromJson(v))
            .toList()
        : [];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['j_type'] = jType;
    data['j_role'] = jRole;
    data['description'] = description;
    data['TypeofEmployment'] = typeofEmployment;
    data['years_of_experience'] = yearsOfExperience;
    data['dental_practice_id'] = dentalPracticeId;
    data['dental_supplier_id'] = dentalSupplierId;
    data['location'] = location;
    data['logo'] = logo;
    data['state'] = state;
    data['city'] = city;
    data['company_name'] = companyName;
    data['salary'] = salary;
    data['website_url'] = websiteUrl;
    data['pay_range'] = payRange;
    data['education'] = education;
    data['video'] = video;
    data['rate_billing'] = rateBilling;
    data['created_at'] = createdAt;
    if (jobApplicantsAggregate != null) {
      data['job_applicants_aggregate'] = jobApplicantsAggregate!.toJson();
    }
    data['country'] = country;
    data['days_of_week'] = daysOfWeek;
    data['current_company'] = currentCompany;
    data['endDateToggle'] = endDateToggle;
    data['experience'] = experience;
    data['facebook_url'] = facebookUrl;
    data['hiring_period'] = hiringPeriod;
    data['instagram_url'] = instagramUrl;
    data['is_featured'] = isFeatured;
    data['closing_message'] = closingMessage;
    data['closed_at'] = closedAt;
    if (clinicLogo != null) {
      data['clinic_logo'] = clinicLogo!.map((v) => v.toJson()).toList();
    }
    data['banner_image'] = bannerImage;
    data['availability_date'] = availabilityDate;
    data['address'] = address;
    data['active_status'] = activeStatus;
    data['pay_min'] = payMin;
    data['pay_max'] = payMax;
    return data;
  }
}
