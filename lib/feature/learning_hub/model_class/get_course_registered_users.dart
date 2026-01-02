class GetCourseRegisteredUsersRes {
  RegisteredUsersData? data;

  GetCourseRegisteredUsersRes({this.data});

  GetCourseRegisteredUsersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new RegisteredUsersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RegisteredUsersData {
  List<CourseRegisteredUsers>? courseRegisteredUsers;

  RegisteredUsersData({this.courseRegisteredUsers});

  RegisteredUsersData.fromJson(Map<String, dynamic> json) {
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
  int? phoneNumber;
  String? description;
  String? courseId;
  String? fromId;
  String? createdAt;
  dynamic? webinarStatus;
  String? status;
  DirectoriesSupplier? directoriesPractice;
  DirectoriesSupplier? directoriesSupplier;
  DirectoriesSupplier? directoriesProfessional;
  String? sTypename;

  CourseRegisteredUsers(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.description,
      this.courseId,
      this.fromId,
      this.createdAt,
      this.webinarStatus,
      this.status,
      this.directoriesPractice,
      this.directoriesSupplier,
      this.directoriesProfessional,
      this.sTypename});

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
    webinarStatus = json['webinar_status'];
    status = json['status'];
    directoriesPractice = json['directories_practice'];
    directoriesSupplier = json['directories_supplier'] != null
        ? new DirectoriesSupplier.fromJson(json['directories_supplier'])
        : null;
    directoriesProfessional = json['directories_professional'];
    sTypename = json['__typename'];
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
    data['webinar_status'] = this.webinarStatus;
    data['status'] = this.status;
    data['directories_practice'] = this.directoriesPractice;
    if (this.directoriesSupplier != null) {
      data['directories_supplier'] = this.directoriesSupplier!.toJson();
    }
    data['directories_professional'] = this.directoriesProfessional;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DirectoriesSupplier {
  String? id;
  DentalSupplier? dentalSupplier;
  String? sTypename;

  DirectoriesSupplier({this.id, this.dentalSupplier, this.sTypename});

  DirectoriesSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplier {
  String? id;
  Logo? logo;
  String? sTypename;

  DentalSupplier({this.id, this.logo, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Logo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Logo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Logo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    status = json['status'];
    fileId = json['file_id'];
    isPublic = json['isPublic'];
    directory = json['directory'];
    extension = json['extension'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['status'] = this.status;
    data['file_id'] = this.fileId;
    data['isPublic'] = this.isPublic;
    data['directory'] = this.directory;
    data['extension'] = this.extension;
    data['mime_type'] = this.mimeType;
    return data;
  }
}
