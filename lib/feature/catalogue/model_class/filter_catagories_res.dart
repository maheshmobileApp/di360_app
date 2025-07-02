class FilterCatagoriesRes {
  CatagoriesData? data;

  FilterCatagoriesRes({this.data});

  FilterCatagoriesRes.fromJson(Map<String, dynamic> json) {
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
  List<FilterCategories>? catalogueCategories;

  CatagoriesData({this.catalogueCategories});

  CatagoriesData.fromJson(Map<String, dynamic> json) {
    if (json['catalogue_categories'] != null) {
      catalogueCategories = <FilterCategories>[];
      json['catalogue_categories'].forEach((v) {
        catalogueCategories!.add(new FilterCategories.fromJson(v));
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

class FilterCategories {
  String? id;
  String? name;
  String? sTypename;

  FilterCategories({this.id, this.name, this.sTypename});

  FilterCategories.fromJson(Map<String, dynamic> json) {
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
