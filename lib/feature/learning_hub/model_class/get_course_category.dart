class GetCourseCategoryRes {
  GetCourseCategories? data;

  GetCourseCategoryRes({this.data});

  GetCourseCategoryRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetCourseCategories.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetCourseCategories {
  List<CourseCategories>? courseCategories;

  GetCourseCategories({this.courseCategories});

  GetCourseCategories.fromJson(Map<String, dynamic> json) {
    if (json['course_categories'] != null) {
      courseCategories = <CourseCategories>[];
      json['course_categories'].forEach((v) {
        courseCategories!.add(new CourseCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseCategories != null) {
      data['course_categories'] =
          this.courseCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseCategories {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? status;

  CourseCategories(
      {this.id, this.createdAt, this.updatedAt, this.name, this.status});

  CourseCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
