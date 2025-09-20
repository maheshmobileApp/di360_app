class GetCourseRegisteredUsers {
  GetUsers? data;

  GetCourseRegisteredUsers({this.data});

  GetCourseRegisteredUsers.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetUsers.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetUsers {
  List<CourseRegisteredUsers>? courseRegisteredUsers;

  GetUsers({this.courseRegisteredUsers});

  GetUsers.fromJson(Map<String, dynamic> json) {
    if (json['course_registered_users'] != null) {
      courseRegisteredUsers = <CourseRegisteredUsers>[];
      json['course_registered_users'].forEach((v) {
        courseRegisteredUsers!.add(new CourseRegisteredUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseRegisteredUsers != null) {
      data['course_registered_users'] =
          this.courseRegisteredUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseRegisteredUsers {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  Null? phoneNumber;
  String? description;
  String? courseId;
  String? fromId;
  String? createdAt;

  CourseRegisteredUsers(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.description,
      this.courseId,
      this.fromId,
      this.createdAt});

  CourseRegisteredUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    description = json['description'];
    courseId = json['course_id'];
    fromId = json['from_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['description'] = this.description;
    data['course_id'] = this.courseId;
    data['from_id'] = this.fromId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
