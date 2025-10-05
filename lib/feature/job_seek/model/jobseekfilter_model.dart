class JobSeekFiltersResponse {
  final JobData? data;

  JobSeekFiltersResponse({this.data});

  factory JobSeekFiltersResponse.fromJson(Map<String, dynamic> json) {
    return JobSeekFiltersResponse(
      data: json['data'] != null ? JobData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

class JobData {
  final List<Job>? jobs;

  JobData({this.jobs});

  factory JobData.fromJson(Map<String, dynamic> json) {
    return JobData(
      jobs: (json['jobs'] as List?)
          ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'jobs': jobs?.map((e) => e.toJson()).toList(),
      };
}

class Job {
  final String? id;
  final String? title;
  final String? jType;
  final String? jRole;
  final String? description;
  final List<String>? typeOfEmployment;
  final String? yearsOfExperience;
  final List<String>? availabilityDate;
  final String? dentalPracticeId;
  final String? dentalSupplierId;
  final String? activeStatus;
  final String? location;
  final String? logo;
  final String? state;
  final String? city;
  final String? salary;
  final String? companyName;
  final String? websiteUrl;
  final String? payRange;
  final String? education;
  final String? video;
  final String? closedAt;
  final String? status;
  final List<String>? offeredBenefits;
  final String? country;
  final String? endDateToggle;
  final num? payMax;
  final num? payMin;
  final String? hiringPeriod;
  final String? noOfPeople;
  final String? rateBilling;
  final String? linkedinUrl;
  final String? instagramUrl;
  final String? facebookUrl;
  final List<ClinicLogo>? clinicLogo;
  final dynamic bannerImage;
  final String? timings;
  final String? timingToggle;
  final String? createdAt;
  final JobApplicantsAggregate? jobApplicantsAggregate;

  Job({
    this.id,
    this.title,
    this.jType,
    this.jRole,
    this.description,
    this.typeOfEmployment,
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
    this.bannerImage,
    this.timings,
    this.timingToggle,
    this.createdAt,
    this.jobApplicantsAggregate,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      jType: json['j_type'],
      jRole: json['j_role'],
      description: json['description'],
      typeOfEmployment: (json['TypeofEmployment'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      yearsOfExperience: json['years_of_experience'],
      availabilityDate: (json['availability_date'] as List?)
          ?.map((e) => e.toString())
          .toList(),
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
      offeredBenefits: (json['offered_benefits'] as List?)
          ?.map((e) => e.toString())
          .toList(),
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
      clinicLogo: (json['clinic_logo'] is List)
          ? (json['clinic_logo'] as List)
              .map((e) => ClinicLogo.fromJson(e))
              .toList()
          : null,
      bannerImage: json['banner_image'],
      timings: json['timings'],
      timingToggle: json['timingtoggle'],
      createdAt: json['created_at'],
      jobApplicantsAggregate: json['job_applicants_aggregate'] != null
          ? JobApplicantsAggregate.fromJson(json['job_applicants_aggregate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'j_type': jType,
        'j_role': jRole,
        'description': description,
        'TypeofEmployment': typeOfEmployment,
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
        'clinic_logo': clinicLogo?.map((e) => e.toJson()).toList(),
        'banner_image': bannerImage,
        'timings': timings,
        'timingtoggle': timingToggle,
        'created_at': createdAt,
        'job_applicants_aggregate': jobApplicantsAggregate?.toJson(),
      };
}

class ClinicLogo {
  final String? url;
  final String? name;
  final String? type;
  final String? extension;

  ClinicLogo({this.url, this.name, this.type, this.extension});

  factory ClinicLogo.fromJson(Map<String, dynamic> json) {
    return ClinicLogo(
      url: json['url'],
      name: json['name'],
      type: json['type'],
      extension: json['extension'],
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
        'type': type,
        'extension': extension,
      };
}

class JobApplicantsAggregate {
  final Aggregate? aggregate;

  JobApplicantsAggregate({this.aggregate});

  factory JobApplicantsAggregate.fromJson(Map<String, dynamic> json) {
    return JobApplicantsAggregate(
      aggregate: json['aggregate'] != null
          ? Aggregate.fromJson(json['aggregate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'aggregate': aggregate?.toJson(),
      };
}

class Aggregate {
  final int? count;

  Aggregate({this.count});

  factory Aggregate.fromJson(Map<String, dynamic> json) {
    return Aggregate(
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
      };
}
