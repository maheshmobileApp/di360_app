class JobPost {
  final String dentalPracticeId;
  final String jobRoleId;
  final String jobTypeId;
  final String title;
  final String description;
  final String rolesAndResponsibilities;
  final Address address;
  final List<String> daysOfWeek;
  final String timings;
  final String status;
  final bool isFeatured;
  final BannerImage bannerImage;
  final Video video;
  final String websiteUrl;
  final int numberOfPositions;
  final String state;
  final String city;
  final String location;
  final List<String> typeOfEmployment;
  final String logo;
  final String salary;
  final String dentalSupplierId;
  final String jType;
  final String jRole;
  final String companyName;
  final String payRange;
  final String education;
  final String experience;
  final List<String> skills;
  final List<String> jobExperiences;
  final String jobLocation;
  final String jobDesignation;
  final String currentCompany;
  final String activeStatus;
  final String country;
  final String hiringPeriod;
  final String noOfPeople;
  final String rateBilling;
  final String offeredSupplement;
  final String facebookUrl;
  final String instagramUrl;
  final String linkedinUrl;
  final String twitterUrl;
  final String endDateToggle;
  final List<String> offeredBenefits;
  final String timingToggle;
  final ClinicLogo clinicLogo;
  final int payMin;
  final int payMax;
  final String yearsOfExperience;
  final List<String> availabilityDate;
  final String autoExpiryDate;
  final String activeStatusFeed;
  final String feedType;

  JobPost({
    required this.dentalPracticeId,
    required this.jobRoleId,
    required this.jobTypeId,
    required this.title,
    required this.description,
    required this.rolesAndResponsibilities,
    required this.address,
    required this.daysOfWeek,
    required this.timings,
    required this.status,
    required this.isFeatured,
    required this.bannerImage,
    required this.video,
    required this.websiteUrl,
    required this.numberOfPositions,
    required this.state,
    required this.city,
    required this.location,
    required this.typeOfEmployment,
    required this.logo,
    required this.salary,
    required this.dentalSupplierId,
    required this.jType,
    required this.jRole,
    required this.companyName,
    required this.payRange,
    required this.education,
    required this.experience,
    required this.skills,
    required this.jobExperiences,
    required this.jobLocation,
    required this.jobDesignation,
    required this.currentCompany,
    required this.activeStatus,
    required this.country,
    required this.hiringPeriod,
    required this.noOfPeople,
    required this.rateBilling,
    required this.offeredSupplement,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.linkedinUrl,
    required this.twitterUrl,
    required this.endDateToggle,
    required this.offeredBenefits,
    required this.timingToggle,
    required this.clinicLogo,
    required this.payMin,
    required this.payMax,
    required this.yearsOfExperience,
    required this.availabilityDate,
    required this.autoExpiryDate,
    required this.activeStatusFeed,
    required this.feedType,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) => JobPost(
        dentalPracticeId: json['dental_practice_id'],
        jobRoleId: json['job_role_id'],
        jobTypeId: json['job_type_id'],
        title: json['title'],
        description: json['description'],
        rolesAndResponsibilities: json['roles_and_responsibilities'],
        address: Address.fromJson(json['address']),
        daysOfWeek: List<String>.from(json['days_of_week']),
        timings: json['timings'],
        status: json['status'],
        isFeatured: json['is_featured'],
        bannerImage: BannerImage.fromJson(json['banner_image']),
        video: Video.fromJson(json['video']),
        websiteUrl: json['website_url'],
        numberOfPositions: json['number_of_positions'],
        state: json['state'],
        city: json['city'],
        location: json['location'],
        typeOfEmployment: List<String>.from(json['TypeofEmployment']),
        logo: json['logo'],
        salary: json['salary'],
        dentalSupplierId: json['dental_supplier_id'],
        jType: json['j_type'],
        jRole: json['j_role'],
        companyName: json['company_name'],
        payRange: json['pay_range'],
        education: json['education'],
        experience: json['experience'],
        skills: List<String>.from(json['skills']),
        jobExperiences: List<String>.from(json['jobexperiences']),
        jobLocation: json['job_location'],
        jobDesignation: json['job_designation'],
        currentCompany: json['current_company'],
        activeStatus: json['active_status'],
        country: json['country'],
        hiringPeriod: json['hiring_period'],
        noOfPeople: json['no_of_people'],
        rateBilling: json['rate_billing'],
        offeredSupplement: json['offered_supplement'],
        facebookUrl: json['facebook_url'],
        instagramUrl: json['instagram_url'],
        linkedinUrl: json['linkedin_url'],
        twitterUrl: json['twitter_url'],
        endDateToggle: json['endDateToggle'],
        offeredBenefits: List<String>.from(json['offered_benefits']),
        timingToggle: json['timingtoggle'],
        clinicLogo: ClinicLogo.fromJson(json['clinic_logo']),
        payMin: json['pay_min'],
        payMax: json['pay_max'],
        yearsOfExperience: json['years_of_experience'],
        availabilityDate: List<String>.from(json['availability_date']),
        autoExpiryDate: json['auto_expiry_date'],
        activeStatusFeed: json['active_status_feed'],
        feedType: json['feed_type'],
      );

  Map<String, dynamic> toJson() => {
        'dental_practice_id': dentalPracticeId,
        'job_role_id': jobRoleId,
        'job_type_id': jobTypeId,
        'title': title,
        'description': description,
        'roles_and_responsibilities': rolesAndResponsibilities,
        'address': address.toJson(),
        'days_of_week': daysOfWeek,
        'timings': timings,
        'status': status,
        'is_featured': isFeatured,
        'banner_image': bannerImage.toJson(),
        'video': video.toJson(),
        'website_url': websiteUrl,
        'number_of_positions': numberOfPositions,
        'state': state,
        'city': city,
        'location': location,
        'TypeofEmployment': typeOfEmployment,
        'logo': logo,
        'salary': salary,
        'dental_supplier_id': dentalSupplierId,
        'j_type': jType,
        'j_role': jRole,
        'company_name': companyName,
        'pay_range': payRange,
        'education': education,
        'experience': experience,
        'skills': skills,
        'jobexperiences': jobExperiences,
        'job_location': jobLocation,
        'job_designation': jobDesignation,
        'current_company': currentCompany,
        'active_status': activeStatus,
        'country': country,
        'hiring_period': hiringPeriod,
        'no_of_people': noOfPeople,
        'rate_billing': rateBilling,
        'offered_supplement': offeredSupplement,
        'facebook_url': facebookUrl,
        'instagram_url': instagramUrl,
        'linkedin_url': linkedinUrl,
        'twitter_url': twitterUrl,
        'endDateToggle': endDateToggle,
        'offered_benefits': offeredBenefits,
        'timingtoggle': timingToggle,
        'clinic_logo': clinicLogo.toJson(),
        'pay_min': payMin,
        'pay_max': payMax,
        'years_of_experience': yearsOfExperience,
        'availability_date': availabilityDate,
        'auto_expiry_date': autoExpiryDate,
        'active_status_feed': activeStatusFeed,
        'feed_type': feedType,
      };
}

class Address {
  final String street;
  final String city;
  final String postcode;

  Address({required this.street, required this.city, required this.postcode});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'],
        city: json['city'],
        postcode: json['postcode'],
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'postcode': postcode,
      };
}

class BannerImage {
  final String url;
  final String name;

  BannerImage({required this.url, required this.name});

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
        url: json['url'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'name': name,
      };
}

class Video {
  final String url;

  Video({required this.url});

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
      };
}

class ClinicLogo {
  final String url;

  ClinicLogo({required this.url});

  factory ClinicLogo.fromJson(Map<String, dynamic> json) => ClinicLogo(
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
      };
}
