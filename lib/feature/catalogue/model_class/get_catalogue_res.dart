import 'package:di360_flutter/feature/catalogue/model_class/catalouges_list.dart';

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

  CatalogueCategories.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? businessName;
  String? sTypename;

  DentalSupplier({this.name, this.businessName, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['business_name'] = this.businessName;
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
