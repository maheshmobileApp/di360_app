class CatalogueSubCatagoriesRes {
  CatagoriesData? data;

  CatalogueSubCatagoriesRes({this.data});

  CatalogueSubCatagoriesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CatagoriesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CatagoriesData {
  List<CatalogueSubCategories>? catalogueSubCategories;

  CatagoriesData({this.catalogueSubCategories});

  CatagoriesData.fromJson(Map<String, dynamic> json) {
    if (json['catalogue_sub_categories'] != null) {
      catalogueSubCategories = <CatalogueSubCategories>[];
      json['catalogue_sub_categories'].forEach((v) {
        catalogueSubCategories!.add(new CatalogueSubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.catalogueSubCategories != null) {
      data['catalogue_sub_categories'] =
          this.catalogueSubCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatalogueSubCategories {
  String? id;
  String? name;
  String? sTypename;

  CatalogueSubCategories({this.id, this.name, this.sTypename});

  CatalogueSubCategories.fromJson(Map<String, dynamic> json) {
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
