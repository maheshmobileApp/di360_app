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
  List<SupplySubCategories>? supplySubCategories;
  String? sTypename;

  SupplyCategories(
      {this.id, this.name, this.supplySubCategories, this.sTypename});

  SupplyCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['supply_sub_categories'] != null) {
      supplySubCategories = <SupplySubCategories>[];
      json['supply_sub_categories'].forEach((v) {
        supplySubCategories!.add(new SupplySubCategories.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.supplySubCategories != null) {
      data['supply_sub_categories'] =
          this.supplySubCategories!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplySubCategories {
  String? id;
  String? name;
  String? sTypename;

  SupplySubCategories({this.id, this.name, this.sTypename});

  SupplySubCategories.fromJson(Map<String, dynamic> json) {
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
