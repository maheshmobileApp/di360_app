class SupplyCategoriesRes {
  SupplyCategoriesData? data;

  SupplyCategoriesRes({this.data});

  SupplyCategoriesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplyCategoriesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplyCategoriesData {
  List<SupplyCategories>? supplyCategories;

  SupplyCategoriesData({this.supplyCategories});

  SupplyCategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['supply_categories'] != null) {
      supplyCategories = <SupplyCategories>[];
      json['supply_categories'].forEach((v) {
        supplyCategories!.add(new SupplyCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplyCategories != null) {
      data['supply_categories'] =
          this.supplyCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplyCategories {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? sTypename;

  SupplyCategories(
      {this.id, this.name, this.createdAt, this.updatedAt, this.sTypename});

  SupplyCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__typename'] = this.sTypename;
    return data;
  }
}
