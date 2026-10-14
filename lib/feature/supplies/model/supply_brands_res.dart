class SupplyBrandsRes {
  SupplyBrandsData? data;

  SupplyBrandsRes({this.data});

  SupplyBrandsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplyBrandsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplyBrandsData {
  List<SupplyBrands>? supplyBrands;

  SupplyBrandsData({this.supplyBrands});

  SupplyBrandsData.fromJson(Map<String, dynamic> json) {
    if (json['supply_brands'] != null) {
      supplyBrands = <SupplyBrands>[];
      json['supply_brands'].forEach((v) {
        supplyBrands!.add(new SupplyBrands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplyBrands != null) {
      data['supply_brands'] =
          this.supplyBrands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplyBrands {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? sTypename;

  SupplyBrands(
      {this.id, this.createdAt, this.updatedAt, this.name, this.sTypename});

  SupplyBrands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}
