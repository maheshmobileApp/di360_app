class JobSeekResponseModel {
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
  Map<String, dynamic>? offeredBenefits;
  String? country;
  bool? endDateToggle;
  String? payMax;
  String? payMin;
  String? hiringPeriod;
  String? noOfPeople;
  String? rateBilling;
  String? linkedinUrl;
  String? instagramUrl;
  String? facebookUrl;
  String? clinicLogo;
  String? timings;
  String? bannerImage;
  bool? timingToggle;
  String? createdAt;

  int? applicantsCount;

  JobSeekResponseModel({
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
    this.applicantsCount,
  });

  factory JobSeekResponseModel.fromJson(Map<String, dynamic> json) {
    return JobSeekResponseModel(
      id: json['id'],
      title: json['title'],
      jType: json['j_type'],
      jRole: json['j_role'],
      description: json['description'],
      typeofEmployment: json['TypeofEmployment'],
      yearsOfExperience: json['years_of_experience'],
      availabilityDate: json['availability_date'],
      dentalPracticeId: json['dental_practice_id'],
      dentalSupplierId: json['dental_supplier_id'],
      activeStatus: json['active_status'],
      location: json['location'],
      logo: json['logo'],
      state: json['state'],
      city: json['city'],
      salary: json['salary'],
      companyName: json['company_name'],
      websiteUrl: json['website_url'],
      payRange: json['pay_range'],
      education: json['education'],
      video: json['video'],
      closedAt: json['closed_at'],
      status: json['status'],
      offeredBenefits: json['offered_benefits'],
      country: json['country'],
      endDateToggle: json['endDateToggle'],
      payMax: json['pay_max'],
      payMin: json['pay_min'],
      hiringPeriod: json['hiring_period'],
      noOfPeople: json['no_of_people'],
      rateBilling: json['rate_billing'],
      linkedinUrl: json['linkedin_url'],
      instagramUrl: json['instagram_url'],
      facebookUrl: json['facebook_url'],
      clinicLogo: json['clinic_logo'],
      timings: json['timings'],
      bannerImage: json['banner_image'],
      timingToggle: json['timingtoggle'],
      createdAt: json['created_at'],
      applicantsCount: json['job_applicants_aggregate'] != null &&
              json['job_applicants_aggregate']['aggregate'] != null
          ? json['job_applicants_aggregate']['aggregate']['count']
          : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'j_type': jType,
      'j_role': jRole,
      'description': description,
      'TypeofEmployment': typeofEmployment,
      'years_of_experience': yearsOfExperience,
      'availability_date': availabilityDate,
      'dental_practice_id': dentalPracticeId,
      'dental_supplier_id': dentalSupplierId,
      'active_status': activeStatus,
      'location': location,
      'logo': logo,
      'state': state,
      'city': city,
      'salary': salary,
      'company_name': companyName,
      'website_url': websiteUrl,
      'pay_range': payRange,
      'education': education,
      'video': video,
      'closed_at': closedAt,
      'status': status,
      'offered_benefits': offeredBenefits,
      'country': country,
      'endDateToggle': endDateToggle,
      'pay_max': payMax,
      'pay_min': payMin,
      'hiring_period': hiringPeriod,
      'no_of_people': noOfPeople,
      'rate_billing': rateBilling,
      'linkedin_url': linkedinUrl,
      'instagram_url': instagramUrl,
      'facebook_url': facebookUrl,
      'clinic_logo': clinicLogo,
      'timings': timings,
      'banner_image': bannerImage,
      'timingtoggle': timingToggle,
      'created_at': createdAt,
      'applicants_count': applicantsCount,
    };
  }
}
