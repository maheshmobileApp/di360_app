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
  List<Address>? address;
  Attachments? attachments;
  List<CourseEventInfo>? courseEventInfo;
  List<Presenters>? presenters;
  SeoMetadata? seoMetadata;
  List<SponsorByImage>? sponsorByImage;
  int? afterwardsPrice;
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
  List<CourseDetailRegisteredUsers>? courseRegisteredUsers;
  CourseRegisteredUsersAggregate? courseRegisteredUsersAggregate;
  String? sTypename;

  CoursesByPk(
      {this.id,
      this.courseName,
      this.isFeatured,
      this.numberOfSeats,
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
      this.courseRegisteredUsers,
      this.courseRegisteredUsersAggregate,
      this.sTypename});

  CoursesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    isFeatured = json['is_featured'];
    numberOfSeats = (json['number_of_seats'] as num?)?.toInt();
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
    if (json['module_section'] != null) {
      moduleSection = <ModuleSection>[];
      json['module_section'].forEach((v) {
        moduleSection!.add(new ModuleSection.fromJson(v));
      });
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
  String? id;
  String? moduleName;
  List<SectionList>? sectionList;

  ModuleSection({this.expanded, this.id, this.moduleName, this.sectionList});

  ModuleSection.fromJson(Map<String, dynamic> json) {
    expanded = json['expanded'];
    id = json['id'];
    moduleName = json['module_name'];
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
    data['id'] = this.id;
    data['module_name'] = this.moduleName;
    if (this.sectionList != null) {
      data['section_list'] = this.sectionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionList {
  dynamic attachment;
  String? courseTopic;
  String? description;
  bool? expanded;
  String? id;
  dynamic image;
  String? status;
  dynamic youtubeLink;

  SectionList(
      {this.attachment,
      this.courseTopic,
      this.description,
      this.expanded,
      this.id,
      this.image,
      this.status,
      this.youtubeLink});

  SectionList.fromJson(Map<String, dynamic> json) {
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
  String? courseId;
  String? fromId;
  String? status;
  String? sTypename;

  CourseDetailRegisteredUsers(
      {this.courseId, this.fromId, this.status, this.sTypename});

  CourseDetailRegisteredUsers.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    fromId = json['from_id'];
    status = json['status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['from_id'] = this.fromId;
    data['status'] = this.status;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class QuestionSection {
  List<Options>? options;
  String? question;
  String? type;

  QuestionSection({this.options, this.question, this.type});

  QuestionSection.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    question = json['question'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['question'] = this.question;
    data['type'] = this.type;
    return data;
  }
}

class Options {
  bool? isCorrect;
  String? text;

  Options({this.isCorrect, this.text});

  Options.fromJson(Map<String, dynamic> json) {
    isCorrect = json['isCorrect'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCorrect'] = this.isCorrect;
    data['text'] = this.text;
    return data;
  }
}
