class CoursesResponse {
  CoursesListingData? data;

  CoursesResponse({this.data});

  CoursesResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CoursesListingData.fromJson(json['data']) : null;
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
  String? courseName;
  String? type;
  String? startDate;
  String? endDate;
  PresentedByImage? presentedByImage;
  String? presentedByName;
  String? description;
  String? companyName;
  String? status;
  String? activeStatus;
  String? createdById;
  CourseRegisteredUsersAggregate? courseRegisteredUsersAggregate;

  CoursesListingDetails(
      {this.id,
      this.createdAt,
      this.courseName,
      this.type,
      this.startDate,
      this.endDate,
      this.presentedByImage,
      this.presentedByName,
      this.description,
      this.companyName,
      this.status,
      this.activeStatus,
      this.createdById,
      this.courseRegisteredUsersAggregate});

  CoursesListingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    courseName = json['course_name'];
    type = json['type'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    presentedByImage = json['presented_by_image'] != null
        ? new PresentedByImage.fromJson(json['presented_by_image'])
        : null;
    presentedByName = json['presented_by_name'];
    description = json['description'];
    companyName = json['company_name'];
    status = json['status'];
    activeStatus = json['active_status'];
    createdById = json['created_by_id'];
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
    data['course_name'] = this.courseName;
    data['type'] = this.type;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    if (this.presentedByImage != null) {
      data['presented_by_image'] = this.presentedByImage!.toJson();
    }
    data['presented_by_name'] = this.presentedByName;
    data['description'] = this.description;
    data['company_name'] = this.companyName;
    data['status'] = this.status;
    data['active_status'] = this.activeStatus;
    data['created_by_id'] = this.createdById;
    if (this.courseRegisteredUsersAggregate != null) {
      data['course_registered_users_aggregate'] =
          this.courseRegisteredUsersAggregate!.toJson();
    }
    return data;
  }
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
