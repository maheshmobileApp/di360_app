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
  String? dentalSupplierId;
  Attachment? attachment;
  int? monthsCount;
  String? schedulerDay;
  Attachment? thumbnailImage;
  int? views;
  String? status;
  String? rejectReason;
  CatalogueCategory? catalogueCategory;
  String? sTypename;

  CataloguesByPk(
      {this.id,
      this.title,
      this.dentalSupplierId,
      this.attachment,
      this.monthsCount,
      this.schedulerDay,
      this.thumbnailImage,
      this.views,
      this.status,
      this.rejectReason,
      this.catalogueCategory,
      this.sTypename});

  CataloguesByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dentalSupplierId = json['dental_supplier_id'];
    attachment = json['attachment'] != null
        ? new Attachment.fromJson(json['attachment'])
        : null;
    monthsCount = json['months_count'];
    schedulerDay = json['schedulerDay'];
    thumbnailImage = json['thumbnail_image'] != null
        ? new Attachment.fromJson(json['thumbnail_image'])
        : null;
    views = json['views'];
    status = json['status'];
    rejectReason = json['reject_reason'];
    catalogueCategory = json['catalogue_category'] != null
        ? new CatalogueCategory.fromJson(json['catalogue_category'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.toJson();
    }
    data['months_count'] = this.monthsCount;
    data['schedulerDay'] = this.schedulerDay;
    if (this.thumbnailImage != null) {
      data['thumbnail_image'] = this.thumbnailImage!.toJson();
    }
    data['views'] = this.views;
    data['status'] = this.status;
    data['reject_reason'] = this.rejectReason;
    if (this.catalogueCategory != null) {
      data['catalogue_category'] = this.catalogueCategory!.toJson();
    }
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
