class SupplySubCategoriesRes {
  SupplySubCategoriesData? data;

  SupplySubCategoriesRes({this.data});

  SupplySubCategoriesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplySubCategoriesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplySubCategoriesData {
  List<SupplySubCategories>? supplySubCategories;

  SupplySubCategoriesData({this.supplySubCategories});

  SupplySubCategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['supply_sub_categories'] != null) {
      supplySubCategories = <SupplySubCategories>[];
      json['supply_sub_categories'].forEach((v) {
        supplySubCategories!.add(new SupplySubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplySubCategories != null) {
      data['supply_sub_categories'] =
          this.supplySubCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplySubCategories {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? sTypename;

  SupplySubCategories(
      {this.id, this.name, this.createdAt, this.updatedAt, this.sTypename});

  SupplySubCategories.fromJson(Map<String, dynamic> json) {
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
