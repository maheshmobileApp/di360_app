class CatagorysRes {
  CatagoryData? data;

  CatagorysRes({this.data});

  CatagorysRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CatagoryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CatagoryData {
  List<CatalogueCategories>? catalogueCategories;

  CatagoryData({this.catalogueCategories});

  CatagoryData.fromJson(Map<String, dynamic> json) {
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
  CataloguesAggregate? cataloguesAggregate;
  String? sTypename;

  CatalogueCategories(
      {this.id, this.name, this.cataloguesAggregate, this.sTypename});

  CatalogueCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cataloguesAggregate = json['catalogues_aggregate'] != null
        ? new CataloguesAggregate.fromJson(json['catalogues_aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.cataloguesAggregate != null) {
      data['catalogues_aggregate'] = this.cataloguesAggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CataloguesAggregate {
  Aggregate? aggregate;
  String? sTypename;

  CataloguesAggregate({this.aggregate, this.sTypename});

  CataloguesAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Aggregate {
  int? count;
  String? sTypename;

  Aggregate({this.count, this.sTypename});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['__typename'] = this.sTypename;
    return data;
  }
}
