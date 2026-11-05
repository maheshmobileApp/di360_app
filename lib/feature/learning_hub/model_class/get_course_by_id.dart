class GetCourseByIdRes {
  CourseByIdData? data;

  GetCourseByIdRes({this.data});

  GetCourseByIdRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CourseByIdData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CourseByIdData {
  CoursesByPk? coursesByPk;

  CourseByIdData({this.coursesByPk});

  CourseByIdData.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  String? updatedAt;
  String? courseName;
  String? type;
  Null? presentedByImage;
  Null? presentedByName;
  String? status;
  String? activeStatus;
  dynamic? afterwardsPrice;
  List<Presenters>? presenters;
  String? createdById;
  String? endDate;
  String? startDate;
  dynamic? cpdPoints;
  String? shortCode;
  DentalSupplier? dentalSupplier;
  String? sTypename;

  CoursesByPk(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.courseName,
      this.type,
      this.presentedByImage,
      this.presentedByName,
      this.status,
      this.activeStatus,
      this.afterwardsPrice,
      this.presenters,
      this.createdById,
      this.endDate,
      this.startDate,
      this.cpdPoints,
      this.shortCode,
      this.dentalSupplier,
      this.sTypename});

  CoursesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseName = json['course_name'];
    type = json['type'];
    presentedByImage = json['presented_by_image'];
    presentedByName = json['presented_by_name'];
    status = json['status'];
    activeStatus = json['active_status'];
    afterwardsPrice = json['afterwards_price'];
    if (json['presenters'] != null) {
      presenters = <Presenters>[];
      json['presenters'].forEach((v) {
        presenters!.add(new Presenters.fromJson(v));
      });
    }
    createdById = json['created_by_id'];
    endDate = json['endDate'];
    startDate = json['startDate'];
    cpdPoints = json['cpd_points'];
    shortCode = json['short_code'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_name'] = this.courseName;
    data['type'] = this.type;
    data['presented_by_image'] = this.presentedByImage;
    data['presented_by_name'] = this.presentedByName;
    data['status'] = this.status;
    data['active_status'] = this.activeStatus;
    data['afterwards_price'] = this.afterwardsPrice;
    if (this.presenters != null) {
      data['presenters'] = this.presenters!.map((v) => v.toJson()).toList();
    }
    data['created_by_id'] = this.createdById;
    data['endDate'] = this.endDate;
    data['startDate'] = this.startDate;
    data['cpd_points'] = this.cpdPoints;
    data['short_code'] = this.shortCode;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
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

class DentalSupplier {
  String? id;
  Null? logo;
  String? sTypename;

  DentalSupplier({this.id, this.logo, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['__typename'] = this.sTypename;
    return data;
  }
}
