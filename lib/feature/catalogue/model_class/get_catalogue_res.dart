class GetCatalogueRes {
  CatalogueData? data;

  GetCatalogueRes({this.data});

  GetCatalogueRes.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new CatalogueData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CatalogueData {
  List<CatalogueCategories>? catalogueCategories;

  CatalogueData({this.catalogueCategories});

  CatalogueData.fromJson(Map<String, dynamic> json) {
    if (json['catalogue_categories'] != null) {
      catalogueCategories = <CatalogueCategories>[];
      json['catalogue_categories'].forEach((v) {
        catalogueCategories!.add(new CatalogueCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.catalogueCategories != null) {
      data['catalogue_categories'] =
          this.catalogueCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatalogueCategories {
  String? id;
  String? name;
  List<Catalogues>? catalogues;
  String? sTypename;

  CatalogueCategories({this.id, this.name, this.catalogues, this.sTypename});

  CatalogueCategories. fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['catalogues'] != null) {
      catalogues = <Catalogues>[];
      json['catalogues'].forEach((v) {
        catalogues!.add(new Catalogues.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.catalogues != null) {
      data['catalogues'] = this.catalogues!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Catalogues {
  String? id;
  String? title;
  String? status;
  ThumbnailImage? thumbnailImage;
  String? schedulerDay;
  DentalSupplier? dentalSupplier;
  List<CatalogueFavorites>? catalogueFavorites;
  String? sTypename;

  Catalogues(
      {this.id,
      this.title,
      this.status,
      this.thumbnailImage,
      this.schedulerDay,
      this.dentalSupplier,
      this.catalogueFavorites,
      this.sTypename});

  Catalogues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    if (json['thumbnail_image'] != null) {
      if (json['thumbnail_image'] is Map<String, dynamic>) {
        thumbnailImage = ThumbnailImage.fromJson(json['thumbnail_image']);
      } else if (json['thumbnail_image'] is List) {
        final list = json['thumbnail_image'] as List;
        if (list.isNotEmpty) {
          thumbnailImage = ThumbnailImage.fromJson(list[0]);
        }
      }
    } else {
      thumbnailImage = null;
    }
    schedulerDay = json['schedulerDay'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    if (json['catalogue_favorites'] != null) {
      catalogueFavorites = <CatalogueFavorites>[];
      json['catalogue_favorites'].forEach((v) {
        catalogueFavorites!.add(new CatalogueFavorites.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    if (this.thumbnailImage != null) {
      data['thumbnail_image'] = this.thumbnailImage!.toJson();
    }
    data['schedulerDay'] = this.schedulerDay;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    if (this.catalogueFavorites != null) {
      data['catalogue_favorites'] =
          this.catalogueFavorites!.map((v) => v.toJson()).toList();
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

class DentalSupplier {
  List<Directories>? directories;
  String? sTypename;

  DentalSupplier({this.directories, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Directories {
  String? name;
  String? sTypename;

  Directories({this.name, this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
