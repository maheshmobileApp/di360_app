class NewsfeedsLikes {
  String? dentalAdminId;
  NewsLikeAdminUser? adminUser;
  NewsFeedLikePractice? dentalPractice;
  NewsFeedLikeSupplier? dentalSupplier;
  NewsFeedLikeProfessional? dentalProfessional;
  String? sTypename;

  NewsfeedsLikes(
      {this.dentalAdminId,
      this.adminUser,
      this.dentalPractice,
      this.dentalSupplier,
      this.dentalProfessional,
      this.sTypename});

  NewsfeedsLikes.fromJson(Map<String, dynamic> json) {
    dentalAdminId = json['dental_admin_id'];
    adminUser = json['admin_user'] != null
        ? new NewsLikeAdminUser.fromJson(json['admin_user'])
        : null;
    dentalPractice = json['dental_practice'] != null
        ? new NewsFeedLikePractice.fromJson(json['dental_practice'])
        : null;
    dentalSupplier = json['dental_supplier'] != null
        ? new NewsFeedLikeSupplier.fromJson(json['dental_supplier'])
        : null;
    dentalProfessional = json['dental_professional'] != null
        ? new NewsFeedLikeProfessional.fromJson(json['dental_professional'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dental_admin_id'] = this.dentalAdminId;
    if (this.adminUser != null) {
      data['admin_user'] = this.adminUser!.toJson();
    }
    if (this.dentalPractice != null) {
      data['dental_practice'] = this.dentalPractice!.toJson();
    }
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class NewsLikeAdminUser {
  String? id;
  String? name;
  String? sTypename;

  NewsLikeAdminUser({this.id, this.name, this.sTypename});

  NewsLikeAdminUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class NewsFeedLikePractice {
  String? id;
  String? name;
  DentalPracticeLogo? logo;
  String? type;
  dynamic professionType;
  String? sTypename;

  NewsFeedLikePractice(
      {this.id,
      this.name,
      this.logo,
      this.type,
      this.professionType,
      this.sTypename});

  NewsFeedLikePractice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null
        ? new DentalPracticeLogo.fromJson(json['logo'])
        : null;
    type = json['type'];
    professionType = json['profession_type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['type'] = this.type;
    data['profession_type'] = this.professionType;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalPracticeLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  DentalPracticeLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  DentalPracticeLogo.fromJson(Map<String, dynamic> json) {
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

class NewsFeedLikeSupplier {
  String? id;
  String? name;
  DentalSupplierLogo? logo;
  String? type;
  dynamic professionType;
  String? sTypename;

  NewsFeedLikeSupplier(
      {this.id,
      this.name,
      this.logo,
      this.type,
      this.professionType,
      this.sTypename});

  NewsFeedLikeSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null
        ? new DentalSupplierLogo.fromJson(json['logo'])
        : null;
    type = json['type'];
    professionType = json['profession_type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['type'] = this.type;
    data['profession_type'] = this.professionType;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplierLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  DentalSupplierLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  DentalSupplierLogo.fromJson(Map<String, dynamic> json) {
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

class NewsFeedLikeProfessional {
  String? id;
  String? name;
  dynamic professionType;
  String? type;
  ProfileImage? profileImage;
  String? sTypename;

  NewsFeedLikeProfessional(
      {this.id,
      this.name,
      this.professionType,
      this.type,
      this.profileImage,
      this.sTypename});

  NewsFeedLikeProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    professionType = json['profession_type'];
    type = json['type'];
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profession_type'] = this.professionType;
    data['type'] = this.type;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ProfileImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  ProfileImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  ProfileImage.fromJson(Map<String, dynamic> json) {
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
