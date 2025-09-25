class CatalogueViewRes {
  CatalogData? data;

  CatalogueViewRes({this.data});

  CatalogueViewRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CatalogData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CatalogData {
  CataloguesByPk? cataloguesByPk;

  CatalogData({this.cataloguesByPk});

  CatalogData.fromJson(Map<String, dynamic> json) {
    cataloguesByPk = json['catalogues_by_pk'] != null
        ? new CataloguesByPk.fromJson(json['catalogues_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cataloguesByPk != null) {
      data['catalogues_by_pk'] = this.cataloguesByPk!.toJson();
    }
    return data;
  }
}

class CataloguesByPk {
  String? id;
  String? title;
  Attachment? attachment;
  ThumbnailImage? thumbnailImage;
  String? catalogueStatus;
  String? schedulerDay;
  dynamic monthsCount;
  String? expiryDay;
  CatalogueCategory? catalogueCategory;
  CatalogueSubCategory? catalogueSubCategory;
  List<Null>? jCataloguesCatalogueTags;
  String? sTypename;

  CataloguesByPk(
      {this.id,
      this.title,
      this.attachment,
      this.thumbnailImage,
      this.catalogueStatus,
      this.schedulerDay,
      this.monthsCount,
      this.expiryDay,
      this.catalogueCategory,
      this.catalogueSubCategory,
      this.jCataloguesCatalogueTags,
      this.sTypename});

  CataloguesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    attachment = json['attachment'] != null
        ? new Attachment.fromJson(json['attachment'])
        : null;
    thumbnailImage = json['thumbnail_image'] != null
        ? new ThumbnailImage.fromJson(json['thumbnail_image'])
        : null;
    catalogueStatus = json['catalogue_status'];
    schedulerDay = json['schedulerDay'];
    monthsCount = json['months_count'];
    expiryDay = json['expiryDay'];
    catalogueCategory = json['catalogue_category'] != null
        ? new CatalogueCategory.fromJson(json['catalogue_category'])
        : null;
    catalogueSubCategory = json['catalogue_sub_category'] != null
        ? new CatalogueSubCategory.fromJson(json['catalogue_sub_category'])
        : null;
    // if (json['j_catalogues_catalogue_tags'] != null) {
    //   jCataloguesCatalogueTags = <Null>[];
    //   json['j_catalogues_catalogue_tags'].forEach((v) {
    //     jCataloguesCatalogueTags!.add(new Null.fromJson(v));
    //   });
    // }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.toJson();
    }
    if (this.thumbnailImage != null) {
      data['thumbnail_image'] = this.thumbnailImage!.toJson();
    }
    data['catalogue_status'] = this.catalogueStatus;
    data['schedulerDay'] = this.schedulerDay;
    data['months_count'] = this.monthsCount;
    data['expiryDay'] = this.expiryDay;
    if (this.catalogueCategory != null) {
      data['catalogue_category'] = this.catalogueCategory!.toJson();
    }
    if (this.catalogueSubCategory != null) {
      data['catalogue_sub_category'] = this.catalogueSubCategory!.toJson();
    }
    // if (this.jCataloguesCatalogueTags != null) {
    //   data['j_catalogues_catalogue_tags'] =
    //       this.jCataloguesCatalogueTags!.map((v) => v.toJson()).toList();
    // }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Attachment {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Attachment(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Attachment.fromJson(Map<String, dynamic> json) {
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

class ThumbnailImage {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  ThumbnailImage(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  ThumbnailImage.fromJson(Map<String, dynamic> json) {
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

class CatalogueCategory {
  String? id;
  String? name;
  String? sTypename;

  CatalogueCategory({this.id, this.name, this.sTypename});

  CatalogueCategory.fromJson(Map<String, dynamic> json) {
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

class CatalogueSubCategory {
  String? id;
  String? name;
  String? sTypename;

  CatalogueSubCategory({this.id, this.name, this.sTypename});

  CatalogueSubCategory.fromJson(Map<String, dynamic> json) {
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
