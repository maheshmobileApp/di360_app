class DentalPractice {
  String? id;
  DentalPracticeLogo? logo;
  dynamic businessName;
  dynamic professionType;
  String? email;
  String? phone;
  String? name;
  String? type;
  List<DentalPracticesDirectories>? directories;
  String? sTypename;

  DentalPractice(
      {this.id,
      this.logo,
      this.businessName,
      this.professionType,
      this.email,
      this.phone,
      this.name,
      this.type,
      this.directories,
      this.sTypename});

  DentalPractice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'] != null ? new DentalPracticeLogo.fromJson(json['logo']) : null;
    businessName = json['business_name'];
    professionType = json['profession_type'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    type = json['type'];
    if (json['directories'] != null) {
      directories = <DentalPracticesDirectories>[];
      json['directories'].forEach((v) {
        directories!.add(new DentalPracticesDirectories.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['business_name'] = this.businessName;
    data['profession_type'] = this.professionType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
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

class DentalPracticesDirectories {
  String? companyName;
  PracticeLogo? logo;
  String? description;
  PracticeBannerImage? bannerImage;
  String? sTypename;

  DentalPracticesDirectories(
      {this.companyName,
      this.logo,
      this.description,
      this.bannerImage,
      this.sTypename});

  DentalPracticesDirectories.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    logo = json['logo'] != null ? new PracticeLogo.fromJson(json['logo']) : null;
    description = json['description'];
    bannerImage = json['banner_image'] != null
        ? new PracticeBannerImage.fromJson(json['banner_image'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['description'] = this.description;
    if (this.bannerImage != null) {
      data['banner_image'] = this.bannerImage!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class PracticeLogo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  PracticeLogo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  PracticeLogo.fromJson(Map<String, dynamic> json) {
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

class PracticeBannerImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  PracticeBannerImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  PracticeBannerImage.fromJson(Map<String, dynamic> json) {
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