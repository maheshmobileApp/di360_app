class GetCatalogueTypeRes {
  CatalogueTypeData? data;

  GetCatalogueTypeRes({this.data});

  GetCatalogueTypeRes.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new CatalogueTypeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CatalogueTypeData {
  List<CatalogueTypes>? catalogueCategories;

  CatalogueTypeData({this.catalogueCategories});

  CatalogueTypeData.fromJson(Map<String, dynamic> json) {
    if (json['catalogue_categories'] != null) {
      catalogueCategories = <CatalogueTypes>[];
      json['catalogue_categories'].forEach((v) {
        catalogueCategories!.add(new CatalogueTypes.fromJson(v));
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

class CatalogueTypes {
  String? id;
  String? name;
  String? sTypename;

  CatalogueTypes({this.id, this.name, this.sTypename});

  CatalogueTypes.fromJson(Map<String, dynamic> json) {
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
