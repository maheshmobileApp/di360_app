class NewCourseModel {
  CourseObject? object;

  NewCourseModel({this.object});

  NewCourseModel.fromJson(Map<String, dynamic> json) {
    object = json['object'] != null ? CourseObject.fromJson(json['object']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (object != null) {
      data['object'] = object!.toJson();
    }
    return data;
  }
}

class CourseObject {
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
  int? maxSubscribers;
  int? priceInAud;
  int? priceInUsd;
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
  List<SponsorByImage>? sponsorByImage;
  String? terms;
  String? refundPolicy;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? contactWebsite;
  double? cpdPoints;
  int? numberOfSeats;
  int? earlyBirdPrice;
  int? afterwardsPrice;
  List<CourseGallery>? courseGallery;
  List<CourseBannerVideo>? courseBannerVideo;
  List<CourseBannerImage>? courseBannerImage;
  String? registerLink;
  String? feedType;
  String? activeStatusFeed;
  String? userRole;
  String? rsvpDate;
  String? startDate;
  String? endDate;
  String? startTime;

  CourseObject({
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
  });

  CourseObject.fromJson(Map<String, dynamic> json) {
    courseCategoryId = json['course_category_id'];
    shortId = json['short_id'];
    courseName = json['course_name'];
    shortInfo = json['short_info'];
    image = json['image'];
    video = json['video'];
    completeDetails = json['complete_details'];
    attachments = json['attachments'] != null ? Attachments.fromJson(json['attachments']) : null;
    isFeatured = json['is_featured'];
    activeStatus = json['active_status'];
    type = json['type'];
    address = json['address'];
    scheduledAt = json['scheduled_at'];
    maxSubscribers = json['max_subscribers'];
    priceInAud = json['price_in_aud'];
    priceInUsd = json['price_in_usd'];
    seoMetadata = json['seo_metadata'] != null ? SeoMetadata.fromJson(json['seo_metadata']) : null;
    webinarLink = json['webinar_link'];
    presentedByImage = json['presented_by_image'] != null ? PresentedByImage.fromJson(json['presented_by_image']) : null;
    presentedByName = json['presented_by_name'];
    description = json['description'];
    if (json['course_event_info'] != null) {
      courseEventInfo = <CourseEventInfo>[];
      json['course_event_info'].forEach((v) {
        courseEventInfo!.add(CourseEventInfo.fromJson(v));
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
      sponsorByImage = <SponsorByImage>[];
      json['sponsor_by_image'].forEach((v) {
        sponsorByImage!.add(SponsorByImage.fromJson(v));
      });
    }
    terms = json['terms'];
    refundPolicy = json['refund_policy'];
    contactName = json['contact_name'];
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    contactWebsite = json['contact_website'];
    cpdPoints = json['cpd_points'] != null ? double.tryParse(json['cpd_points'].toString()) : null;
    numberOfSeats = json['number_of_seats'];
    earlyBirdPrice = json['early_bird_price'];
    afterwardsPrice = json['afterwards_price'];
    if (json['course_gallery'] != null) {
      courseGallery = <CourseGallery>[];
      json['course_gallery'].forEach((v) {
        courseGallery!.add(CourseGallery.fromJson(v));
      });
    }
    if (json['course_banner_video'] != null) {
      courseBannerVideo = <CourseBannerVideo>[];
      json['course_banner_video'].forEach((v) {
        courseBannerVideo!.add(CourseBannerVideo.fromJson(v));
      });
    }
    if (json['course_banner_image'] != null) {
      courseBannerImage = <CourseBannerImage>[];
      json['course_banner_image'].forEach((v) {
        courseBannerImage!.add(CourseBannerImage.fromJson(v));
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_category_id'] = courseCategoryId;
    data['short_id'] = shortId;
    data['course_name'] = courseName;
    data['short_info'] = shortInfo;
    data['image'] = image;
    data['video'] = video;
    data['complete_details'] = completeDetails;
    if (attachments != null) {
      data['attachments'] = attachments!.toJson();
    }
    data['is_featured'] = isFeatured;
    data['active_status'] = activeStatus;
    data['type'] = type;
    data['address'] = address;
    data['scheduled_at'] = scheduledAt;
    data['max_subscribers'] = maxSubscribers;
    data['price_in_aud'] = priceInAud;
    data['price_in_usd'] = priceInUsd;
    if (seoMetadata != null) {
      data['seo_metadata'] = seoMetadata!.toJson();
    }
    data['webinar_link'] = webinarLink;
    if (presentedByImage != null) {
      data['presented_by_image'] = presentedByImage!.toJson();
    }
    data['presented_by_name'] = presentedByName;
    data['description'] = description;
    if (courseEventInfo != null) {
      data['course_event_info'] = courseEventInfo!.map((v) => v.toJson()).toList();
    }
    data['early_bird_end_date'] = earlyBirdEndDate;
    data['topics_included'] = topicsIncluded;
    data['learning_objectives'] = learningObjectives;
    data['event_type'] = eventType;
    data['created_by_id'] = createdById;
    data['company_name'] = companyName;
    data['status'] = status;
    if (sponsorByImage != null) {
      data['sponsor_by_image'] = sponsorByImage!.map((v) => v.toJson()).toList();
    }
    data['terms'] = terms;
    data['refund_policy'] = refundPolicy;
    data['contact_name'] = contactName;
    data['contact_email'] = contactEmail;
    data['contact_phone'] = contactPhone;
    data['contact_website'] = contactWebsite;
    data['cpd_points'] = cpdPoints;
    data['number_of_seats'] = numberOfSeats;
    data['early_bird_price'] = earlyBirdPrice;
    data['afterwards_price'] = afterwardsPrice;
    if (courseGallery != null) {
      data['course_gallery'] = courseGallery!.map((v) => v.toJson()).toList();
    }
    if (courseBannerVideo != null) {
      data['course_banner_video'] = courseBannerVideo!.map((v) => v.toJson()).toList();
    }
    if (courseBannerImage != null) {
      data['course_banner_image'] = courseBannerImage!.map((v) => v.toJson()).toList();
    }
    data['register_link'] = registerLink;
    data['feed_type'] = feedType;
    data['active_status_feed'] = activeStatusFeed;
    data['user_role'] = userRole;
    data['rsvp_date'] = rsvpDate;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    return data;
  }
}

/* Supporting classes */

class Attachments {
  String? name;

  Attachments({this.name});

  Attachments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {'name': name};
}

class SeoMetadata {
  List<String>? keywords;

  SeoMetadata({this.keywords});

  SeoMetadata.fromJson(Map<String, dynamic> json) {
    if (json['keywords'] != null) {
      keywords = List<String>.from(json['keywords']);
    }
  }

  Map<String, dynamic> toJson() => {'keywords': keywords};
}

class PresentedByImage {
  String? url;

  PresentedByImage({this.url});

  PresentedByImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() => {'url': url};
}

class SponsorByImage {
  String? url;
  String? name;

  SponsorByImage({this.url, this.name});

  SponsorByImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {'url': url, 'name': name};
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

  Map<String, dynamic> toJson() => {'url': url, 'name': name, 'size': size, 'type': type};
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

  Map<String, dynamic> toJson() => {'url': url, 'name': name, 'size': size, 'type': type};
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

  Map<String, dynamic> toJson() => {'url': url, 'name': name, 'size': size, 'type': type};
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
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['info'] = info;
    data['name'] = name;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
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

  Map<String, dynamic> toJson() => {'url': url, 'name': name, 'size': size, 'type': type};
}
