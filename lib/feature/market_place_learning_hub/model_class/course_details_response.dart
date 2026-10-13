class courseDetailsResponse {
  CourseDetailData? data;

  courseDetailsResponse({this.data});

  courseDetailsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new CourseDetailData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CourseDetailData {
  CoursesByPk? coursesByPk;

  CourseDetailData({this.coursesByPk});

  CourseDetailData.fromJson(Map<String, dynamic> json) {
    coursesByPk = json['courses_by_pk'] != null
        ? new CoursesByPk.fromJson(json['courses_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coursesByPk != null) {
      data['courses_by_pk'] = this.coursesByPk!.toJson();
    }
    return data;
  }
}

class CoursesByPk {
  String? id;
  String? courseName;
  bool? isFeatured;
  int? numberOfSeats;
  bool? isLifetime;
  List<Address>? address;
  Attachments? attachments;
  List<CourseEventInfo>? courseEventInfo;
  List<Presenters>? presenters;
  SeoMetadata? seoMetadata;
  List<SponsorByImage>? sponsorByImage;
  int? afterwardsPrice;
  int? courseAccessDuration;
  int? cpdPoints;
  dynamic earlyBirdPrice;
  String? communityId;
  String? communityUserType;
  int? maxSubscribers;
  dynamic priceInAud;
  dynamic priceInUsd;
  String? companyName;
  dynamic completeDetails;
  String? contactEmail;
  String? contactName;
  String? contactPhone;
  String? contactWebsite;
  String? registerLink;
  String? description;
  dynamic earlyBirdEndDate;
  String? endDate;
  String? eventType;
  dynamic image;
  dynamic learningObjectives;
  List<ModuleSection>? moduleSection;
  List<QuestionSection>? questionSection;
  dynamic passPercentage;
  String? refundPolicy;
  dynamic shortId;
  dynamic shortInfo;
  String? startDate;
  String? status;
  String? terms;
  dynamic topicsIncluded;
  dynamic video;
  String? webinarLink;
  String? createdAt;
  dynamic scheduledAt;
  String? updatedAt;
  String? courseCategoryId;
  String? createdById;
  List<CourseBannerVideo>? courseBannerVideo;
  List<CourseGallery>? courseGallery;
  String? activeStatus;
  String? startTime;
  String? endTime;
  String? type;
  List<CourseBannerImage>? courseBannerImage;
  String? facebookLink;
  String? instagramLink;
  String? linkedinLink;
  String? youtubeLink;
  List<ModuleDetails>? moduleDetails;
  List<QuizDetails>? quizDetails;
  List<CourseDetailRegisteredUsers>? courseRegisteredUsers;
  CourseRegisteredUsersAggregate? courseRegisteredUsersAggregate;
  String? sTypename;

  CoursesByPk(
      {this.id,
      this.courseName,
      this.isFeatured,
      this.numberOfSeats,
      this.isLifetime,
      this.courseAccessDuration,
      this.address,
      this.attachments,
      this.courseEventInfo,
      this.presenters,
      this.seoMetadata,
      this.sponsorByImage,
      this.afterwardsPrice,
      this.cpdPoints,
      this.earlyBirdPrice,
      this.communityId,
      this.communityUserType,
      this.maxSubscribers,
      this.priceInAud,
      this.priceInUsd,
      this.companyName,
      this.completeDetails,
      this.contactEmail,
      this.contactName,
      this.contactPhone,
      this.contactWebsite,
      this.registerLink,
      this.description,
      this.earlyBirdEndDate,
      this.endDate,
      this.eventType,
      this.image,
      this.learningObjectives,
      this.moduleSection,
      this.questionSection,
      this.passPercentage,
      this.refundPolicy,
      this.shortId,
      this.shortInfo,
      this.startDate,
      this.status,
      this.terms,
      this.topicsIncluded,
      this.video,
      this.webinarLink,
      this.createdAt,
      this.scheduledAt,
      this.updatedAt,
      this.courseCategoryId,
      this.createdById,
      this.courseBannerVideo,
      this.courseGallery,
      this.activeStatus,
      this.startTime,
      this.endTime,
      this.type,
      this.courseBannerImage,
      this.facebookLink,
      this.instagramLink,
      this.linkedinLink,
      this.youtubeLink,
      this.moduleDetails,
      this.quizDetails,
      this.courseRegisteredUsers,
      this.courseRegisteredUsersAggregate,
      this.sTypename});

  CoursesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    isFeatured = json['is_featured'];
    numberOfSeats = (json['number_of_seats'] as num?)?.toInt();
    isLifetime = json['is_lifetime'];
    courseAccessDuration = (json['course_access_duration'] as num?)?.toInt();
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    attachments = json['attachments'];
    if (json['course_event_info'] != null) {
      courseEventInfo = <CourseEventInfo>[];
      json['course_event_info'].forEach((v) {
        courseEventInfo!.add(new CourseEventInfo.fromJson(v));
      });
    }
    if (json['presenters'] != null) {
      presenters = <Presenters>[];
      json['presenters'].forEach((v) {
        presenters!.add(new Presenters.fromJson(v));
      });
    }
    seoMetadata = json['seo_metadata'];
    if (json['sponsor_by_image'] != null) {
      sponsorByImage = <SponsorByImage>[];
      json['sponsor_by_image'].forEach((v) {
        sponsorByImage!.add(new SponsorByImage.fromJson(v));
      });
    }
    afterwardsPrice = (json['afterwards_price'] as num?)?.toInt();
    cpdPoints = (json['cpd_points'] as num?)?.toInt();
    earlyBirdPrice = json['early_bird_price'];
    communityId = json['community_id'];
    communityUserType = json['community_user_type'];
    maxSubscribers = (json['max_subscribers'] as num?)?.toInt();
    priceInAud = json['price_in_aud'];
    priceInUsd = json['price_in_usd'];
    companyName = json['company_name'];
    completeDetails = json['complete_details'];
    contactEmail = json['contact_email'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    contactWebsite = json['contact_website'];
    registerLink = json['register_link'];
    description = json['description'];
    earlyBirdEndDate = json['early_bird_end_date'];
    endDate = json['endDate'];
    eventType = json['event_type'];
    image = json['image'];
    learningObjectives = json['learning_objectives'];
    final moduleSectionJson = json['module_section'];
    if (moduleSectionJson is List) {
      moduleSection = <ModuleSection>[];
      for (final section in moduleSectionJson) {
        if (section is Map) {
          moduleSection!
              .add(ModuleSection.fromJson(Map<String, dynamic>.from(section)));
        }
      }
    } else if (moduleSectionJson is Map) {
      moduleSection = <ModuleSection>[
        ModuleSection.fromJson(Map<String, dynamic>.from(moduleSectionJson))
      ];
    }
    if (json['question_section'] != null) {
      questionSection = <QuestionSection>[];
      json['question_section'].forEach((v) {
        questionSection!.add(new QuestionSection.fromJson(v));
      });
    }
    passPercentage = json['pass_percentage'];
    refundPolicy = json['refund_policy'];
    shortId = json['short_id'];
    shortInfo = json['short_info'];
    startDate = json['startDate'];
    status = json['status'];
    terms = json['terms'];
    topicsIncluded = json['topics_included'];
    video = json['video'];
    webinarLink = json['webinar_link'];
    createdAt = json['created_at'];
    scheduledAt = json['scheduled_at'];
    updatedAt = json['updated_at'];
    courseCategoryId = json['course_category_id'];
    createdById = json['created_by_id'];
    if (json['course_banner_video'] != null) {
      courseBannerVideo = <CourseBannerVideo>[];
      json['course_banner_video'].forEach((v) {
        courseBannerVideo!.add(new CourseBannerVideo.fromJson(v));
      });
    }
    if (json['course_gallery'] != null) {
      courseGallery = <CourseGallery>[];
      json['course_gallery'].forEach((v) {
        courseGallery!.add(new CourseGallery.fromJson(v));
      });
    }
    activeStatus = json['active_status'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    type = json['type'];
    if (json['course_banner_image'] != null) {
      courseBannerImage = <CourseBannerImage>[];
      json['course_banner_image'].forEach((v) {
        courseBannerImage!.add(new CourseBannerImage.fromJson(v));
      });
    }
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    linkedinLink = json['linkedin_link'];
    youtubeLink = json['youtube_link'];
    if (json['module_details'] != null) {
      moduleDetails = <ModuleDetails>[];
      json['module_details'].forEach((v) {
        moduleDetails!.add(new ModuleDetails.fromJson(v));
      });
    }
    if (json['quiz_details'] != null) {
      quizDetails = <QuizDetails>[];
      json['quiz_details'].forEach((v) {
        quizDetails!.add(new QuizDetails.fromJson(v));
      });
    }
    if (json['course_registered_users'] != null) {
      courseRegisteredUsers = <CourseDetailRegisteredUsers>[];
      json['course_registered_users'].forEach((v) {
        courseRegisteredUsers!.add(new CourseDetailRegisteredUsers.fromJson(v));
      });
    }
    courseRegisteredUsersAggregate =
        json['course_registered_users_aggregate'] != null
            ? new CourseRegisteredUsersAggregate.fromJson(
                json['course_registered_users_aggregate'])
            : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['is_featured'] = this.isFeatured;
    data['number_of_seats'] = this.numberOfSeats;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    data['attachments'] = this.attachments;
    if (this.courseEventInfo != null) {
      data['course_event_info'] =
          this.courseEventInfo!.map((v) => v.toJson()).toList();
    }
    if (this.presenters != null) {
      data['presenters'] = this.presenters!.map((v) => v.toJson()).toList();
    }
    data['seo_metadata'] = this.seoMetadata;
    if (this.sponsorByImage != null) {
      data['sponsor_by_image'] =
          this.sponsorByImage!.map((v) => v.toJson()).toList();
    }
    data['afterwards_price'] = this.afterwardsPrice;
    data['cpd_points'] = this.cpdPoints;
    data['early_bird_price'] = this.earlyBirdPrice;
    data['community_id'] = this.communityId;
    data['community_user_type'] = this.communityUserType;
    data['max_subscribers'] = this.maxSubscribers;
    data['price_in_aud'] = this.priceInAud;
    data['price_in_usd'] = this.priceInUsd;
    data['company_name'] = this.companyName;
    data['complete_details'] = this.completeDetails;
    data['contact_email'] = this.contactEmail;
    data['contact_name'] = this.contactName;
    data['contact_phone'] = this.contactPhone;
    data['contact_website'] = this.contactWebsite;
    data['register_link'] = this.registerLink;
    data['description'] = this.description;
    data['early_bird_end_date'] = this.earlyBirdEndDate;
    data['endDate'] = this.endDate;
    data['event_type'] = this.eventType;
    data['image'] = this.image;
    data['learning_objectives'] = this.learningObjectives;
    if (this.moduleSection != null) {
      data['module_section'] =
          this.moduleSection!.map((v) => v.toJson()).toList();
    }
    if (this.questionSection != null) {
      data['question_section'] =
          this.questionSection!.map((v) => v.toJson()).toList();
    }
    data['pass_percentage'] = this.passPercentage;
    data['refund_policy'] = this.refundPolicy;
    data['short_id'] = this.shortId;
    data['short_info'] = this.shortInfo;
    data['startDate'] = this.startDate;
    data['status'] = this.status;
    data['terms'] = this.terms;
    data['topics_included'] = this.topicsIncluded;
    data['video'] = this.video;
    data['webinar_link'] = this.webinarLink;
    data['created_at'] = this.createdAt;
    data['scheduled_at'] = this.scheduledAt;
    data['updated_at'] = this.updatedAt;
    data['course_category_id'] = this.courseCategoryId;
    data['created_by_id'] = this.createdById;
    if (this.courseBannerVideo != null) {
      data['course_banner_video'] =
          this.courseBannerVideo!.map((v) => v.toJson()).toList();
    }
    if (this.courseGallery != null) {
      data['course_gallery'] =
          this.courseGallery!.map((v) => v.toJson()).toList();
    }
    data['active_status'] = this.activeStatus;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['type'] = this.type;
    if (this.courseBannerImage != null) {
      data['course_banner_image'] =
          this.courseBannerImage!.map((v) => v.toJson()).toList();
    }
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['linkedin_link'] = this.linkedinLink;
    data['youtube_link'] = this.youtubeLink;
    if (this.moduleDetails != null) {
      data['module_details'] =
          this.moduleDetails!.map((v) => v.toJson()).toList();
    }
    if (this.quizDetails != null) {
      data['quiz_details'] = this.quizDetails!.map((v) => v.toJson()).toList();
    }
    if (this.courseRegisteredUsers != null) {
      data['course_registered_users'] =
          this.courseRegisteredUsers!.map((v) => v.toJson()).toList();
    }
    if (this.courseRegisteredUsersAggregate != null) {
      data['course_registered_users_aggregate'] =
          this.courseRegisteredUsersAggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Presenters {
  String? presentedByName;
  PresentedByImage? presentedByImage;

  Presenters({this.presentedByName, this.presentedByImage});

  Presenters.fromJson(Map<String, dynamic> json) {
    presentedByName = json['presented_by_name'];
    presentedByImage = json['presented_by_image'] != null
        ? new PresentedByImage.fromJson(json['presented_by_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['presented_by_name'] = this.presentedByName;
    if (this.presentedByImage != null) {
      data['presented_by_image'] = this.presentedByImage!.toJson();
    }
    return data;
  }
}

class PresentedByImage {
  String? url;
  String? name;
  int? size;
  String? type;

  PresentedByImage({this.url, this.name, this.size, this.type});

  PresentedByImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = (json['size'] as num?)?.toInt();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}

class ModuleSection {
  bool? expanded;
  String? moduleId;
  String? moduleName;
  String? modulePosition;
  List<SectionList>? sectionList;

  ModuleSection(
      {this.expanded,
      this.moduleId,
      this.moduleName,
      this.modulePosition,
      this.sectionList});

  ModuleSection.fromJson(Map<String, dynamic> json) {
    expanded = json['expanded'];
    moduleId = json['module_id'];
    moduleName = json['module_name'];
    modulePosition = json['module_position'];
    if (json['section_list'] != null) {
      sectionList = <SectionList>[];
      json['section_list'].forEach((v) {
        sectionList!.add(new SectionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expanded'] = this.expanded;
    data['module_id'] = this.moduleId;
    data['module_name'] = this.moduleName;
    data['module_position'] = this.modulePosition;
    if (this.sectionList != null) {
      data['section_list'] = this.sectionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionList {
  dynamic attachment;
  String? courseTopic;
  bool? expanded;
  String? id;
  dynamic image;
  String? moduleDescription;
  String? sectionPosition;
  String? status;
  String? youtubeLink;

  SectionList(
      {this.attachment,
      this.courseTopic,
      this.expanded,
      this.id,
      this.image,
      this.moduleDescription,
      this.sectionPosition,
      this.status,
      this.youtubeLink});

  SectionList.fromJson(Map<String, dynamic> json) {
    attachment = json['attachment'];
    courseTopic = json['course_topic'];
    expanded = json['expanded'];
    id = json['id'];
    image = json['image'];
    moduleDescription = json['module_description'];
    sectionPosition = json['section_position'];
    status = json['status'];
    youtubeLink = json['youtube_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachment'] = this.attachment;
    data['course_topic'] = this.courseTopic;
    data['expanded'] = this.expanded;
    data['id'] = this.id;
    data['image'] = this.image;
    data['module_description'] = this.moduleDescription;
    data['section_position'] = this.sectionPosition;
    data['status'] = this.status;
    data['youtube_link'] = this.youtubeLink;
    return data;
  }
}

class CourseBannerImage {
  String? url;
  String? name;
  String? type;
  String? extension;

  CourseBannerImage({this.url, this.name, this.type, this.extension});

  CourseBannerImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    type = json['type'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['extension'] = this.extension;
    return data;
  }
}

class CourseRegisteredUsersAggregate {
  Aggregate? aggregate;
  String? sTypename;

  CourseRegisteredUsersAggregate({this.aggregate, this.sTypename});

  CourseRegisteredUsersAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate({this.count, this.sTypename});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Address {
  double? lat;
  double? lng;
  String? city;
  String? state;
  String? street;
  String? country;
  String? postalCode;
  String? formattedAddress;

  Address(
      {this.lat,
      this.lng,
      this.city,
      this.state,
      this.street,
      this.country,
      this.postalCode,
      this.formattedAddress});

  Address.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    city = json['city'];
    state = json['state'];
    street = json['street'];
    country = json['country'];
    postalCode = json['postal_code'];
    formattedAddress = json['formatted_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['city'] = this.city;
    data['state'] = this.state;
    data['street'] = this.street;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['formatted_address'] = this.formattedAddress;
    return data;
  }
}

class Attachments {
  String? name;

  Attachments({this.name});

  Attachments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class CourseGallery {
  String? url;
  String? name;
  int? size;
  String? type;

  CourseGallery({this.url, this.name, this.size, this.type});

  CourseGallery.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = (json['size'] as num?)?.toInt();
    type = json['type'];
  }

  Map<String, dynamic> toJson() =>
      {'url': url, 'name': name, 'size': size, 'type': type};
}

class CourseBannerVideo {
  String? url;
  String? name;
  int? size;
  String? type;

  CourseBannerVideo({this.url, this.name, this.size, this.type});

  CourseBannerVideo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = (json['size'] as num?)?.toInt();
    type = json['type'];
  }

  Map<String, dynamic> toJson() =>
      {'url': url, 'name': name, 'size': size, 'type': type};
}

class CourseEventInfo {
  String? date;
  String? info;
  String? name;
  List<Images>? images;

  CourseEventInfo({this.date, this.info, this.name, this.images});

  CourseEventInfo.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    info = json['info'];
    name = json['name'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['info'] = this.info;
    data['name'] = this.name;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? url;
  String? name;
  int? size;
  String? type;

  Images({this.url, this.name, this.size, this.type});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = (json['size'] as num?)?.toInt();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}

class SeoMetadata {
  List<String>? keywords;

  SeoMetadata({this.keywords});

  SeoMetadata.fromJson(Map<String, dynamic> json) {
    keywords = json['keywords'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keywords'] = this.keywords;
    return data;
  }
}

class SponsorByImage {
  String? url;
  String? name;
  int? size;
  String? type;

  SponsorByImage({this.url, this.name, this.size, this.type});

  SponsorByImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = (json['size'] as num?)?.toInt();
    type = json['type'];
  }

  Map<String, dynamic> toJson() =>
      {'url': url, 'name': name, 'size': size, 'type': type};
}

class CourseDetailRegisteredUsers {
  String? id;
  String? courseId;
  String? fromId;
  String? status;
  String? quizStatus;
  String? courseExpiryAt;
  List<QuizAnswers>? quizAnswers;
  List<RegisteredModuleDetails>? registeredModuleDetails;
  String? courseRegisteredDate;
  String? sTypename;

  CourseDetailRegisteredUsers(
      {this.id,
      this.courseId,
      this.fromId,
      this.status,
      this.quizStatus,
      this.quizAnswers,
      this.registeredModuleDetails,
      this.courseRegisteredDate,
      this.courseExpiryAt,
      this.sTypename});

  CourseDetailRegisteredUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    fromId = json['from_id'];
    status = json['status'];
    quizStatus = json['quiz_status'];
    courseExpiryAt = json['course_expires_at'];
    if (json['quiz_answers'] != null) {
      quizAnswers = <QuizAnswers>[];
      json['quiz_answers'].forEach((v) {
        quizAnswers!.add(new QuizAnswers.fromJson(v));
      });
    }
    if (json['registered_module_details'] != null) {
      registeredModuleDetails = <RegisteredModuleDetails>[];
      json['registered_module_details'].forEach((v) {
        registeredModuleDetails!.add(new RegisteredModuleDetails.fromJson(v));
      });
    }
    courseRegisteredDate = json['course_registered_date'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['from_id'] = this.fromId;
    data['status'] = this.status;
    data['quiz_status'] = this.quizStatus;
    data['course_expires_at'] = this.courseExpiryAt;
    if (this.quizAnswers != null) {
      data['quiz_answers'] = this.quizAnswers!.map((v) => v.toJson()).toList();
    }
    if (this.registeredModuleDetails != null) {
      data['registered_module_details'] =
          this.registeredModuleDetails!.map((v) => v.toJson()).toList();
    }
    data['course_registered_date'] = this.courseRegisteredDate;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class QuizAnswers {
  String? questionId;
  List<String>? selectedOptionIds;

  QuizAnswers({this.questionId, this.selectedOptionIds});

  QuizAnswers.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    selectedOptionIds = json['selected_option_ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['selected_option_ids'] = this.selectedOptionIds;
    return data;
  }
}

class QuestionSection {
  String? id;
  List<Options>? options;
  String? question;
  String? questionType;
  String? quizId;
  String? quizPosition;

  QuestionSection(
      {this.id,
      this.options,
      this.question,
      this.questionType,
      this.quizId,
      this.quizPosition});

  QuestionSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    question = json['question'];
    questionType = json['question_type'];
    quizId = json['quiz_id'];
    quizPosition = json['quiz_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['question'] = this.question;
    data['question_type'] = this.questionType;
    data['quiz_id'] = this.quizId;
    data['quiz_position'] = this.quizPosition;
    return data;
  }
}

class Options {
  String? id;
  bool? isCorrect;
  String? optionPosition;
  String? text;

  Options({this.id, this.isCorrect, this.optionPosition, this.text});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isCorrect = json['isCorrect'];
    optionPosition = json['option_position'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isCorrect'] = this.isCorrect;
    data['option_position'] = this.optionPosition;
    data['text'] = this.text;
    return data;
  }
}

/*class RegisterModuleSection {
  bool? expanded;
  String? id;
  String? moduleName;
  List<RegisterSectionList>? sectionList;

  RegisterModuleSection({this.expanded, this.id, this.moduleName, this.sectionList});

  RegisterModuleSection.fromJson(Map<String, dynamic> json) {
    expanded = json['expanded'];
    id = json['id'];
    moduleName = json['module_name'];
    if (json['section_list'] != null) {
      sectionList = <RegisterSectionList>[];
      json['section_list'].forEach((v) {
        sectionList!.add(new RegisterSectionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expanded'] = this.expanded;
    data['id'] = this.id;
    data['module_name'] = this.moduleName;
    if (this.sectionList != null) {
      data['section_list'] = this.sectionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegisterSectionList {
  dynamic attachment;
  String? courseTopic;
  String? description;
  bool? expanded;
  String? id;
  dynamic image;
  String? status;
  dynamic youtubeLink;

  RegisterSectionList(
      {this.attachment,
      this.courseTopic,
      this.description,
      this.expanded,
      this.id,
      this.image,
      this.status,
      this.youtubeLink});

  RegisterSectionList.fromJson(Map<String, dynamic> json) {
    attachment = json['attachment'];
    courseTopic = json['course_topic'];
    description = json['description'];
    expanded = json['expanded'];
    id = json['id'];
    image = json['image'];
    status = json['status'];
    youtubeLink = json['youtube_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachment'] = this.attachment;
    data['course_topic'] = this.courseTopic;
    data['description'] = this.description;
    data['expanded'] = this.expanded;
    data['id'] = this.id;
    data['image'] = this.image;
    data['status'] = this.status;
    data['youtube_link'] = this.youtubeLink;
    return data;
  }
}*/

class ModuleDetails {
  String? id;
  String? moduleName;
  bool? expanded;
  String? moduleId;
  String? courseId;
  String? modulePosition;
  List<SectionDetails>? sectionDetails;
  String? sTypename;

  ModuleDetails(
      {this.id,
      this.moduleName,
      this.expanded,
      this.moduleId,
      this.courseId,
      this.modulePosition,
      this.sectionDetails,
      this.sTypename});

  ModuleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleName = json['module_name'];
    expanded = json['expanded'];
    moduleId = json['module_id'];
    courseId = json['course_id'];
    modulePosition = json['module_position'];
    if (json['section_details'] != null) {
      sectionDetails = <SectionDetails>[];
      json['section_details'].forEach((v) {
        sectionDetails!.add(new SectionDetails.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_name'] = this.moduleName;
    data['expanded'] = this.expanded;
    data['module_id'] = this.moduleId;
    data['course_id'] = this.courseId;
    data['module_position'] = this.modulePosition;
    if (this.sectionDetails != null) {
      data['section_details'] =
          this.sectionDetails!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SectionDetails {
  String? id;
  String? courseTopic;
  String? moduleId;
  String? description;
  dynamic attachment;
  bool? expanded;
  dynamic image;
  String? status;
  String? youtubeLink;
  String? sectionPosition;
  String? sTypename;

  SectionDetails(
      {this.id,
      this.courseTopic,
      this.moduleId,
      this.description,
      this.attachment,
      this.expanded,
      this.image,
      this.status,
      this.youtubeLink,
      this.sectionPosition,
      this.sTypename});

  SectionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseTopic = json['course_topic'];
    moduleId = json['module_id'];
    description = json['description'];
    attachment = json['attachment'];
    expanded = json['expanded'];
    image = json['image'];
    status = json['status'];
    youtubeLink = json['youtube_link'];
    sectionPosition = json['section_position'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_topic'] = this.courseTopic;
    data['module_id'] = this.moduleId;
    data['description'] = this.description;
    data['attachment'] = this.attachment;
    data['expanded'] = this.expanded;
    data['image'] = this.image;
    data['status'] = this.status;
    data['youtube_link'] = this.youtubeLink;
    data['section_position'] = this.sectionPosition;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class QuizDetails {
  String? id;
  String? question;
  String? type;
  String? quizId;
  String? courseId;
  String? quizPosition;
  List<OptionDetails>? optionDetails;
  String? sTypename;

  QuizDetails(
      {this.id,
      this.question,
      this.type,
      this.quizId,
      this.courseId,
      this.quizPosition,
      this.optionDetails,
      this.sTypename});

  QuizDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    type = json['type'];
    quizId = json['quiz_id'];
    courseId = json['course_id'];
    quizPosition = json['quiz_position'];
    if (json['option_details'] != null) {
      optionDetails = <OptionDetails>[];
      json['option_details'].forEach((v) {
        optionDetails!.add(new OptionDetails.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['type'] = this.type;
    data['quiz_id'] = this.quizId;
    data['course_id'] = this.courseId;
    data['quiz_position'] = this.quizPosition;
    if (this.optionDetails != null) {
      data['option_details'] =
          this.optionDetails!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class OptionDetails {
  String? id;
  String? quizId;
  bool? isCorrect;
  String? optionPosition;
  String? text;
  String? sTypename;

  OptionDetails(
      {this.id,
      this.quizId,
      this.isCorrect,
      this.optionPosition,
      this.text,
      this.sTypename});

  OptionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quiz_id'];
    isCorrect = json['isCorrect'];
    optionPosition = json['option_position'];
    text = json['text'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quiz_id'] = this.quizId;
    data['isCorrect'] = this.isCorrect;
    data['option_position'] = this.optionPosition;
    data['text'] = this.text;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class RegisteredModuleDetails {
  String? id;
  String? moduleName;
  bool? expanded;
  String? moduleId;
  String? userId;
  String? sectionStatus;
  String? sectionId;
  String? modulePosition;
  String? sTypename;

  RegisteredModuleDetails(
      {this.id,
      this.moduleName,
      this.expanded,
      this.moduleId,
      this.userId,
      this.sectionStatus,
      this.sectionId,
      this.modulePosition,
      this.sTypename});

  RegisteredModuleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleName = json['module_name'];
    expanded = json['expanded'];
    moduleId = json['module_id'];
    userId = json['user_id'];
    sectionStatus = json['section_status'];
    sectionId = json['section_id'];
    modulePosition = json['module_position'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_name'] = this.moduleName;
    data['expanded'] = this.expanded;
    data['module_id'] = this.moduleId;
    data['user_id'] = this.userId;
    data['section_status'] = this.sectionStatus;
    data['section_id'] = this.sectionId;
    data['module_position'] = this.modulePosition;
    data['__typename'] = this.sTypename;
    return data;
  }
}
