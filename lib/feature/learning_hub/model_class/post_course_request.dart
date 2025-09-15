class PostCourseRequest {
  final PostCourseObj postCourseObj;

  PostCourseRequest({required this.postCourseObj});

  Map<String, dynamic> toJson() => {
        "postCourseObj": postCourseObj.toJson(),
      };

  factory PostCourseRequest.fromJson(Map<String, dynamic> json) {
    return PostCourseRequest(
      postCourseObj: PostCourseObj.fromJson(json["postCourseObj"]),
    );
  }
}

class PostCourseObj {
  final String courseName;
  final String category;
  final String courseFormat;
  final String rsvpDate;
  final String presentedByName;
  final String presentedByImage;
  final String courseHeaderBanner;
  final String gallery;
  final String courseBannerImage;
  final String courseDescription;
  final String cpdPoints;
  final String numberOfSeats;
  final String totalPrice;
  final String earlyBirdPrice;
  final String earlyBirdEndDate;
  final String topicsIncluded;
  final String learningObjectives;
  final String courseInfo;
  final String sessionName;
  final String sessionInfo;
  final String eventImg;
  final String sponsoredBy;
  final String termsConditions;
  final String cancellationRefundPolicy;
  final String name;
  final String phone;
  final String email;
  final String websiteUrl;
  final String registerLink;

  PostCourseObj({
    required this.courseName,
    required this.category,
    required this.courseFormat,
    required this.rsvpDate,
    required this.presentedByName,
    required this.presentedByImage,
    required this.courseHeaderBanner,
    required this.gallery,
    required this.courseBannerImage,
    required this.courseDescription,
    required this.cpdPoints,
    required this.numberOfSeats,
    required this.totalPrice,
    required this.earlyBirdPrice,
    required this.earlyBirdEndDate,
    required this.topicsIncluded,
    required this.learningObjectives,
    required this.courseInfo,
    required this.sessionName,
    required this.sessionInfo,
    required this.eventImg,
    required this.sponsoredBy,
    required this.termsConditions,
    required this.cancellationRefundPolicy,
    required this.name,
    required this.phone,
    required this.email,
    required this.websiteUrl,
    required this.registerLink,
  });

  Map<String, dynamic> toJson() => {
        "course_name": courseName,
        "category": category,
        "course_format": courseFormat,
        "rsvp_date": rsvpDate,
        "presented_by_name": presentedByName,
        "presented_by_image": presentedByImage,
        "course_header_banner": courseHeaderBanner,
        "gallery": gallery,
        "course_banner_image": courseBannerImage,
        "course_descrition": courseDescription,
        "cpd_points": cpdPoints,
        "number_of_seats": numberOfSeats,
        "total_price": totalPrice,
        "early_bird_price": earlyBirdPrice,
        "early_bird_end_date": earlyBirdEndDate,
        "topics_included": topicsIncluded,
        "learning_objectives": learningObjectives,
        "course_info": courseInfo,
        "session_name": sessionName,
        "session_info": sessionInfo,
        "event_img": eventImg,
        "sponsored_by": sponsoredBy,
        "terms_conditions": termsConditions,
        "cancellation_refund_policy": cancellationRefundPolicy,
        "name": name,
        "phone": phone,
        "email": email,
        "website_url": websiteUrl,
        "register_link": registerLink,
      };

  factory PostCourseObj.fromJson(Map<String, dynamic> json) {
    return PostCourseObj(
      courseName: json["course_name"] ?? "",
      category: json["category"] ?? "",
      courseFormat: json["course_format"] ?? "",
      rsvpDate: json["rsvp_date"] ?? "",
      presentedByName: json["presented_by_name"] ?? "",
      presentedByImage: json["presented_by_image"] ?? "",
      courseHeaderBanner: json["course_header_banner"] ?? "",
      gallery: json["gallery"] ?? "",
      courseBannerImage: json["course_banner_image"] ?? "",
      courseDescription: json["course_descrition"] ?? "",
      cpdPoints: json["cpd_points"] ?? "",
      numberOfSeats: json["number_of_seats"] ?? "",
      totalPrice: json["total_price"] ?? "",
      earlyBirdPrice: json["early_bird_price"] ?? "",
      earlyBirdEndDate: json["early_bird_end_date"] ?? "",
      topicsIncluded: json["topics_included"] ?? "",
      learningObjectives: json["learning_objectives"] ?? "",
      courseInfo: json["course_info"] ?? "",
      sessionName: json["session_name"] ?? "",
      sessionInfo: json["session_info"] ?? "",
      eventImg: json["event_img"] ?? "",
      sponsoredBy: json["sponsored_by"] ?? "",
      termsConditions: json["terms_conditions"] ?? "",
      cancellationRefundPolicy: json["cancellation_refund_policy"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      websiteUrl: json["website_url"] ?? "",
      registerLink: json["register_link"] ?? "",
    );
  }
}
