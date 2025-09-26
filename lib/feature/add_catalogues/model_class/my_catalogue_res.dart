class MyCatalogueRes {
  MyCataloguesData? data;

  MyCatalogueRes({this.data});

  MyCatalogueRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new MyCataloguesData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyCataloguesData {
  List<Catalogues>? catalogues;

  MyCataloguesData({this.catalogues});

  MyCataloguesData.fromJson(Map<String, dynamic> json) {
    if (json['catalogues'] != null) {
      catalogues = <Catalogues>[];
      json['catalogues'].forEach((v) {
        catalogues!.add(new Catalogues.fromJson(v));
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

class Catalogues {
  String? id;
  String? title;
  String? catalogueStatus;
  int? views;
  String? status;
  String? schedulerDay;
  String? approvedAt;
  String? pendingAt;
  dynamic rejectedAt;
  int? repeatMonths;
  String? expiryDay;
  String? createdAt;
  DentalSupplier? dentalSupplier;
  CatalogueCategory? catalogueCategory;
  CatalogueSubCategory? catalogueSubCategory;
  String? sTypename;

  Catalogues(
      {this.id,
      this.title,
      this.catalogueStatus,
      this.views,
      this.status,
      this.schedulerDay,
      this.approvedAt,
      this.pendingAt,
      this.rejectedAt,
      this.repeatMonths,
      this.expiryDay,
      this.createdAt,
      this.dentalSupplier,
      this.catalogueCategory,
      this.catalogueSubCategory,
      this.sTypename});

  Catalogues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    catalogueStatus = json['catalogue_status'];
    views = json['views'];
    status = json['status'];
    schedulerDay = json['schedulerDay'];
    approvedAt = json['approved_at'];
    pendingAt = json['pending_at'];
    rejectedAt = json['rejected_at'];
    repeatMonths = json['repeat_months'];
    expiryDay = json['expiryDay'];
    createdAt = json['created_at'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    catalogueCategory = json['catalogue_category'] != null
        ? new CatalogueCategory.fromJson(json['catalogue_category'])
        : null;
    catalogueSubCategory = json['catalogue_sub_category'] != null
        ? new CatalogueSubCategory.fromJson(json['catalogue_sub_category'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['catalogue_status'] = this.catalogueStatus;
    data['views'] = this.views;
    data['status'] = this.status;
    data['schedulerDay'] = this.schedulerDay;
    data['approved_at'] = this.approvedAt;
    data['pending_at'] = this.pendingAt;
    data['rejected_at'] = this.rejectedAt;
    data['repeat_months'] = this.repeatMonths;
    data['expiryDay'] = this.expiryDay;
    data['created_at'] = this.createdAt;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    if (this.catalogueCategory != null) {
      data['catalogue_category'] = this.catalogueCategory!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplier {
  String? name;
  String? sTypename;

  DentalSupplier({this.name, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
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
