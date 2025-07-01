class GetReletedCatalogueRes {
  ReletedCataloguData? data;

  GetReletedCatalogueRes({this.data});

  GetReletedCatalogueRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ReletedCataloguData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReletedCataloguData {
  List<CatalogData>? catalogues;

  ReletedCataloguData({this.catalogues});

  ReletedCataloguData.fromJson(Map<String, dynamic> json) {
    if (json['catalogues'] != null) {
      catalogues = <CatalogData>[];
      json['catalogues'].forEach((v) {
        catalogues!.add(new CatalogData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.catalogues != null) {
      data['catalogues'] = this.catalogues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatalogData {
  String? id;
  String? title;
  String? dentalSupplierId;
  ThumbnailImage? thumbnailImage;
  List<CatalogueFavorites>? catalogueFavorites;
  CatalogueCategory? catalogueCategory;
  String? sTypename;

  CatalogData(
      {this.id,
      this.title,
      this.dentalSupplierId,
      this.thumbnailImage,
      this.catalogueFavorites,
      this.catalogueCategory,
      this.sTypename});

  CatalogData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dentalSupplierId = json['dental_supplier_id'];
    thumbnailImage = json['thumbnail_image'] != null
        ? new ThumbnailImage.fromJson(json['thumbnail_image'])
        : null;
    if (json['catalogue_favorites'] != null) {
      catalogueFavorites = <CatalogueFavorites>[];
      json['catalogue_favorites'].forEach((v) {
        catalogueFavorites!.add(new CatalogueFavorites.fromJson(v));
      });
    }
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
    if (this.thumbnailImage != null) {
      data['thumbnail_image'] = this.thumbnailImage!.toJson();
    }
    if (this.catalogueFavorites != null) {
      data['catalogue_favorites'] =
          this.catalogueFavorites!.map((v) => v.toJson()).toList();
    }
    if (this.catalogueCategory != null) {
      data['catalogue_category'] = this.catalogueCategory!.toJson();
    }
    data['__typename'] = this.sTypename;
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

class CatalogueFavorites {
  String? id;
  String? catalogueId;
  String? type;
  String? dentalSupplierId;
  String? dentalProfessionalId;
  String? dentalPracticeId;
  String? sTypename;

  CatalogueFavorites(
      {this.id,
      this.catalogueId,
      this.type,
      this.dentalSupplierId,
      this.dentalProfessionalId,
      this.dentalPracticeId,
      this.sTypename});

  CatalogueFavorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catalogueId = json['catalogue_id'];
    type = json['type'];
    dentalSupplierId = json['dental_supplier_id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalPracticeId = json['dental_practice_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catalogue_id'] = this.catalogueId;
    data['type'] = this.type;
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_practice_id'] = this.dentalPracticeId;
    data['__typename'] = this.sTypename;
    return data;
  }
}
