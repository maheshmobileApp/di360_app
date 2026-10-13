class CataloguesFilterSupplier {
  CatalogueFilterSupplierData? data;

  CataloguesFilterSupplier({this.data});

  CataloguesFilterSupplier.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CatalogueFilterSupplierData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CatalogueFilterSupplierData {
  List<CataloguesSupplier>? catalogues;

  CatalogueFilterSupplierData({this.catalogues});

  CatalogueFilterSupplierData.fromJson(Map<String, dynamic> json) {
    if (json['catalogues'] != null) {
      catalogues = <CataloguesSupplier>[];
      json['catalogues'].forEach((v) {
        catalogues!.add(new CataloguesSupplier.fromJson(v));
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

class CataloguesSupplier {
  DentalSupplier? dentalSupplier;
  String? sTypename;

  CataloguesSupplier({this.dentalSupplier, this.sTypename});

  CataloguesSupplier.fromJson(Map<String, dynamic> json) {
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplier {
  String? id;
  String? businessName;
  String? communityId;
  String? sTypename;

  DentalSupplier(
      {this.id, this.businessName, this.communityId, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    communityId = json['community_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['community_id'] = this.communityId;
    data['__typename'] = this.sTypename;
    return data;
  }
}
