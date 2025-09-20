class GetCourseTypeRes {
  GetCourseTypes? data;

  GetCourseTypeRes({this.data});

  GetCourseTypeRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetCourseTypes.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetCourseTypes {
  List<CourseType>? courseType;

  GetCourseTypes({this.courseType});

  GetCourseTypes.fromJson(Map<String, dynamic> json) {
    if (json['course_type'] != null) {
      courseType = <CourseType>[];
      json['course_type'].forEach((v) {
        courseType!.add(new CourseType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseType != null) {
      data['course_type'] = this.courseType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseType {
  String? id;
  String? name;
  String? status;

  CourseType({this.id, this.name, this.status});

  CourseType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
