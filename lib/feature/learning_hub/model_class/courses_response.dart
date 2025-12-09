class CoursesResponse {
  CoursesListingData? data;

  CoursesResponse({this.data});

  CoursesResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new CoursesListingData.fromJson(json['data'])
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

class CoursesListingData {
  List<CoursesListingDetails>? courses;
  CoursesListingData({this.courses});
  CoursesListingData.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <CoursesListingDetails>[];
      json['courses'].forEach((v) {
        courses!.add(new CoursesListingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoursesListingDetails {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? courseCategoryId;
  String? shortId;
  String? courseName;
  String? shortInfo;
  String? image;
  String? video;
  String? completeDetails;
  Attachments? attachments;
  bool? isFeatured;
  String? activeStatus;
  String? type;
  String? address;
  String? scheduledAt;
  dynamic maxSubscribers;
  dynamic priceInAud;
  dynamic priceInUsd;
  SeoMetadata? seoMetadata;
  String? webinarLink;
  PresentedByImage? presentedByImage;
  String? presentedByName;
  String? description;
  List<CourseEventInfo>? courseEventInfo;
  String? earlyBirdEndDate;
  String? topicsIncluded;
  String? learningObjectives;
  String? eventType;
  String? createdById;
  String? companyName;
  String? status;
  List<CourseBannerImage>? sponsorByImage;
  String? terms;
  String? refundPolicy;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? contactWebsite;
  dynamic cpdPoints;
  dynamic numberOfSeats;
  dynamic earlyBirdPrice;
  dynamic afterwardsPrice;
  List<CourseBannerImage>? courseGallery;
  List<CourseBannerImage>? courseBannerVideo;
  List<CourseBannerImage>? courseBannerImage;
  String? registerLink;
  String? feedType;
  String? activeStatusFeed;
  String? userRole;
  String? rsvpDate;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? meetingLink;
  CourseRegisteredUsersAggregate? courseRegisteredUsersAggregate;

  CoursesListingDetails(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.courseCategoryId,
      this.shortId,
      this.courseName,
      this.shortInfo,
      this.image,
      this.video,
      this.completeDetails,
      this.attachments,
      this.isFeatured,
      this.activeStatus,
      this.type,
      this.address,
      this.scheduledAt,
      this.maxSubscribers,
      this.priceInAud,
      this.priceInUsd,
      this.seoMetadata,
      this.webinarLink,
      this.presentedByImage,
      this.presentedByName,
      this.description,
      this.courseEventInfo,
      this.earlyBirdEndDate,
      this.topicsIncluded,
      this.learningObjectives,
      this.eventType,
      this.createdById,
      this.companyName,
      this.status,
      this.sponsorByImage,
      this.terms,
      this.refundPolicy,
      this.contactName,
      this.contactEmail,
      this.contactPhone,
      this.contactWebsite,
      this.cpdPoints,
      this.numberOfSeats,
      this.earlyBirdPrice,
      this.afterwardsPrice,
      this.courseGallery,
      this.courseBannerVideo,
      this.courseBannerImage,
      this.registerLink,
      this.feedType,
      this.activeStatusFeed,
      this.userRole,
      this.rsvpDate,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.meetingLink,
      this.courseRegisteredUsersAggregate});

  CoursesListingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseCategoryId = json['course_category_id'];
    shortId = json['short_id'];
    courseName = json['course_name'];
    shortInfo = json['short_info'];
    image = json['image'];
    video = json['video'];
    completeDetails = json['complete_details'];
    attachments = json['attachments'] != null
        ? new Attachments.fromJson(json['attachments'])
        : null;
    isFeatured = json['is_featured'];
    activeStatus = json['active_status'];
    type = json['type'];
    address = json['address'];
    scheduledAt = json['scheduled_at'];
    maxSubscribers = json['max_subscribers'];
    priceInAud = json['price_in_aud'];
    priceInUsd = json['price_in_usd'];
    seoMetadata = json['seo_metadata'] != null
        ? new SeoMetadata.fromJson(json['seo_metadata'])
        : null;
    webinarLink = json['webinar_link'];
    presentedByImage = json['presented_by_image'] != null
        ? new PresentedByImage.fromJson(json['presented_by_image'])
        : null;
    presentedByName = json['presented_by_name'];
    description = json['description'];
    if (json['course_event_info'] != null) {
      courseEventInfo = <CourseEventInfo>[];
      json['course_event_info'].forEach((v) {
        courseEventInfo!.add(new CourseEventInfo.fromJson(v));
      });
    }
    earlyBirdEndDate = json['early_bird_end_date'];
    topicsIncluded = json['topics_included'];
    learningObjectives = json['learning_objectives'];
    eventType = json['event_type'];
    createdById = json['created_by_id'];
    companyName = json['company_name'];
    status = json['status'];
    if (json['sponsor_by_image'] != null) {
      sponsorByImage = <CourseBannerImage>[];
      json['sponsor_by_image'].forEach((v) {
        sponsorByImage!.add(new CourseBannerImage.fromJson(v));
      });
    }
    terms = json['terms'];
    refundPolicy = json['refund_policy'];
    contactName = json['contact_name'];
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    contactWebsite = json['contact_website'];
    cpdPoints = json['cpd_points'];
    numberOfSeats = json['number_of_seats'];
    earlyBirdPrice = json['early_bird_price'];
    afterwardsPrice = json['afterwards_price'];
    if (json['course_gallery'] != null) {
      courseGallery = <CourseBannerImage>[];
      json['course_gallery'].forEach((v) {
        courseGallery!.add(new CourseBannerImage.fromJson(v));
      });
    }
    if (json['course_banner_video'] != null) {
      courseBannerVideo = <CourseBannerImage>[];
      json['course_banner_video'].forEach((v) {
        courseBannerVideo!.add(new CourseBannerImage.fromJson(v));
      });
    }
    if (json['course_banner_image'] != null) {
      courseBannerImage = <CourseBannerImage>[];
      json['course_banner_image'].forEach((v) {
        courseBannerImage!.add(new CourseBannerImage.fromJson(v));
      });
    }
    registerLink = json['register_link'];
    feedType = json['feed_type'];
    activeStatusFeed = json['active_status_feed'];
    userRole = json['user_role'];
    rsvpDate = json['rsvp_date'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    meetingLink = json['meeting_link'];
    courseRegisteredUsersAggregate =
        json['course_registered_users_aggregate'] != null
            ? new CourseRegisteredUsersAggregate.fromJson(
                json['course_registered_users_aggregate'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_category_id'] = this.courseCategoryId;
    data['short_id'] = this.shortId;
    data['course_name'] = this.courseName;
    data['short_info'] = this.shortInfo;
    data['image'] = this.image;
    data['video'] = this.video;
    data['complete_details'] = this.completeDetails;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.toJson();
    }
    data['is_featured'] = this.isFeatured;
    data['active_status'] = this.activeStatus;
    data['type'] = this.type;
    data['address'] = this.address;
    data['scheduled_at'] = this.scheduledAt;
    data['max_subscribers'] = this.maxSubscribers;
    data['price_in_aud'] = this.priceInAud;
    data['price_in_usd'] = this.priceInUsd;
    if (this.seoMetadata != null) {
      data['seo_metadata'] = this.seoMetadata!.toJson();
    }
    data['webinar_link'] = this.webinarLink;
    if (this.presentedByImage != null) {
      data['presented_by_image'] = this.presentedByImage!.toJson();
    }
    data['presented_by_name'] = this.presentedByName;
    data['description'] = this.description;
    if (this.courseEventInfo != null) {
      data['course_event_info'] =
          this.courseEventInfo!.map((v) => v.toJson()).toList();
    }
    data['early_bird_end_date'] = this.earlyBirdEndDate;
    data['topics_included'] = this.topicsIncluded;
    data['learning_objectives'] = this.learningObjectives;
    data['event_type'] = this.eventType;
    data['created_by_id'] = this.createdById;
    data['company_name'] = this.companyName;
    data['status'] = this.status;
    if (this.sponsorByImage != null) {
      data['sponsor_by_image'] =
          this.sponsorByImage!.map((v) => v.toJson()).toList();
    }
    data['terms'] = this.terms;
    data['refund_policy'] = this.refundPolicy;
    data['contact_name'] = this.contactName;
    data['contact_email'] = this.contactEmail;
    data['contact_phone'] = this.contactPhone;
    data['contact_website'] = this.contactWebsite;
    data['cpd_points'] = this.cpdPoints;
    data['number_of_seats'] = this.numberOfSeats;
    data['early_bird_price'] = this.earlyBirdPrice;
    data['afterwards_price'] = this.afterwardsPrice;
    if (this.courseGallery != null) {
      data['course_gallery'] =
          this.courseGallery!.map((v) => v.toJson()).toList();
    }
    if (this.courseBannerVideo != null) {
      data['course_banner_video'] =
          this.courseBannerVideo!.map((v) => v.toJson()).toList();
    }
    if (this.courseBannerImage != null) {
      data['course_banner_image'] =
          this.courseBannerImage!.map((v) => v.toJson()).toList();
    }
    data['register_link'] = this.registerLink;
    data['feed_type'] = this.feedType;
    data['active_status_feed'] = this.activeStatusFeed;
    data['user_role'] = this.userRole;
    data['rsvp_date'] = this.rsvpDate;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['meeting_link'] = this.meetingLink;
    if (this.courseRegisteredUsersAggregate != null) {
      data['course_registered_users_aggregate'] =
          this.courseRegisteredUsersAggregate!.toJson();
    }
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

class Address {
  final String? city;
  final String? country;

  Address({this.city, this.country});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] as String?,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "country": country,
    };
  }
}

class CourseRegisteredUsersAggregate {
  Aggregate? aggregate;

  CourseRegisteredUsersAggregate({this.aggregate});

  CourseRegisteredUsersAggregate.fromJson(Map<String, dynamic> json) {
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

class SponsorByImage {
  String? url;
  String? name;
  int? size;
  String? type;

  SponsorByImage({this.url, this.name, this.size, this.type});

  SponsorByImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() =>
      {'url': url, 'name': name, 'size': size, 'type': type};
}

class PresentedByImage {
  String? url;

  PresentedByImage({this.url});

  PresentedByImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
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

class CourseBannerImage {
  String? url;
  String? name;
  int? size;
  String? type;

  CourseBannerImage({this.url, this.name, this.size, this.type});

  CourseBannerImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() =>
      {'url': url, 'name': name, 'size': size, 'type': type};
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
    size = json['size'];
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
    size = json['size'];
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
    size = json['size'];
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
