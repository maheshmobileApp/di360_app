class AppliedJobRespo {
  final List<AppliedJob>? jobs;

  AppliedJobRespo({this.jobs});

  factory AppliedJobRespo.fromJson(Map<String, dynamic> json) {
    return AppliedJobRespo(
      jobs: (json['jobs'] as List?)
          ?.map((e) => AppliedJob.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobs': jobs?.map((e) => e.toJson()).toList(),
    };
  }
}


class  AppliedJob{
  final String? id;
  final String? title;
  final String? jType;
  final String? jRole;
  final String? description;
  final List<String>? typeOfEmployment;
  final String? yearsOfExperience;
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
  final int? payMax;
  final int? payMin;
  final String? hiringPeriod;
  final String? noOfPeople;
  final String? rateBilling;
  final String? linkedinUrl;
  final String? instagramUrl;
  final String? facebookUrl;
  final List<dynamic>? clinicLogo;
  final String? timings;
  final String? bannerImage;
  final String? timingToggle;
  final String? createdAt;
  final JobApplicantsAggregate? jobApplicantsAggregate;
  final List<JobApplicant>? jobApplicants;
  final List<JobEnquiry>? jobEnquiries;

   AppliedJob({
    this.id,
    this.title,
    this.jType,
    this.jRole,
    this.description,
    this.typeOfEmployment,
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
    this.timingToggle,
    this.createdAt,
    this.jobApplicantsAggregate,
    this.jobApplicants,
    this.jobEnquiries,
  });

  factory  AppliedJob.fromJson(Map<String, dynamic> json) {
    return  AppliedJob(
      id: json['id'],
      title: json['title'],
      jType: json['j_type'],
      jRole: json['j_role'],
      description: json['description'],
      typeOfEmployment:
          (json['TypeofEmployment'] as List?)?.map((e) => e.toString()).toList(),
      yearsOfExperience: json['years_of_experience'],
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
      offeredBenefits:
          (json['offered_benefits'] as List?)?.map((e) => e.toString()).toList(),
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
      jobApplicantsAggregate: json['job_applicants_aggregate'] != null
          ? JobApplicantsAggregate.fromJson(json['job_applicants_aggregate'])
          : null,
      jobApplicants: (json['job_applicants'] as List?)
          ?.map((e) => JobApplicant.fromJson(e))
          .toList(),
      jobEnquiries: (json['job_enquiries'] as List?)
          ?.map((e) => JobEnquiry.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'j_type': jType,
      'j_role': jRole,
      'description': description,
      'TypeofEmployment': typeOfEmployment,
      'years_of_experience': yearsOfExperience,
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
      'job_applicants_aggregate': jobApplicantsAggregate?.toJson(),
      'job_applicants': jobApplicants?.map((e) => e.toJson()).toList(),
      'job_enquiries': jobEnquiries?.map((e) => e.toJson()).toList(),
    };
  }
}

class JobApplicantsAggregate {
  final Aggregate? aggregate;

  JobApplicantsAggregate({this.aggregate});

  factory JobApplicantsAggregate.fromJson(Map<String, dynamic> json) {
    return JobApplicantsAggregate(
      aggregate:
          json['aggregate'] != null ? Aggregate.fromJson(json['aggregate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aggregate': aggregate?.toJson(),
    };
  }
}

class Aggregate {
  final int? count;

  Aggregate({this.count});

  factory Aggregate.fromJson(Map<String, dynamic> json) {
    return Aggregate(count: json['count']);
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
    };
  }
}

class JobApplicant {
  final String? id;
  final String? jobId;
  final String? status;
  final String? dentalProfessionalId;
  final String? message;

  JobApplicant({this.id, this.jobId, this.status, this.dentalProfessionalId, this.message});

  factory JobApplicant.fromJson(Map<String, dynamic> json) {
    return JobApplicant(
      id: json['id'],
      jobId: json['job_id'],
      status: json['status'],
      dentalProfessionalId: json['dental_professional_id'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'status': status,
      'dental_professional_id': dentalProfessionalId,
      'message': message,
    };
  }
}

class JobEnquiry {
  final String? id;
  final String? enquiryUserId;
  final String? enquiryDescription;
  final String? jobId;

  JobEnquiry({this.id, this.enquiryUserId, this.enquiryDescription, this.jobId});

  factory JobEnquiry.fromJson(Map<String, dynamic> json) {
    return JobEnquiry(
      id: json['id'],
      enquiryUserId: json['enquiry_userid'],
      enquiryDescription: json['enquiry_description'],
      jobId: json['job_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enquiry_userid': enquiryUserId,
      'enquiry_description': enquiryDescription,
      'job_id': jobId,
    };
  }
}
