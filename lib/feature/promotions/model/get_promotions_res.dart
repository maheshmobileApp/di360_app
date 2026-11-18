class GetPromotionsRes {
  GetPromotionsData? data;

  GetPromotionsRes({this.data});

  GetPromotionsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GetPromotionsData.fromJson(json['data'])
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

class GetPromotionsData {
  List<SupplyPromotions>? supplyPromotions;
  Total? total;
  Total? active;
  Total? inactive;
  Total? expired;

  GetPromotionsData(
      {this.supplyPromotions,
      this.total,
      this.active,
      this.inactive,
      this.expired});

  GetPromotionsData.fromJson(Map<String, dynamic> json) {
    if (json['supply_promotions'] != null) {
      supplyPromotions = <SupplyPromotions>[];
      json['supply_promotions'].forEach((v) {
        supplyPromotions!.add(new SupplyPromotions.fromJson(v));
      });
    }
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    active = json['active'] != null ? new Total.fromJson(json['active']) : null;
    inactive =
        json['inactive'] != null ? new Total.fromJson(json['inactive']) : null;
    expired =
        json['expired'] != null ? new Total.fromJson(json['expired']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplyPromotions != null) {
      data['supply_promotions'] =
          this.supplyPromotions!.map((v) => v.toJson()).toList();
    }
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    if (this.active != null) {
      data['active'] = this.active!.toJson();
    }
    if (this.inactive != null) {
      data['inactive'] = this.inactive!.toJson();
    }
    if (this.expired != null) {
      data['expired'] = this.expired!.toJson();
    }
    return data;
  }
}

class SupplyPromotions {
  String? id;
  String? name;
  String? type;
  String? scope;
  String? status;
  bool? isActive;
  String? startDate;
  String? endDate;
  bool? appliesToAllProducts;
  Config? config;
  List<SupplyPromotionItems>? supplyPromotionItems;
  String? sTypename;

  SupplyPromotions(
      {this.id,
      this.name,
      this.type,
      this.scope,
      this.status,
      this.isActive,
      this.startDate,
      this.endDate,
      this.appliesToAllProducts,
      this.config,
      this.supplyPromotionItems,
      this.sTypename});

  SupplyPromotions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    scope = json['scope'];
    status = json['status'];
    isActive = json['is_active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    appliesToAllProducts = json['applies_to_all_products'];
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
    if (json['supply_promotion_items'] != null) {
      supplyPromotionItems = <SupplyPromotionItems>[];
      json['supply_promotion_items'].forEach((v) {
        supplyPromotionItems!.add(new SupplyPromotionItems.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['scope'] = this.scope;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['applies_to_all_products'] = this.appliesToAllProducts;
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    if (this.supplyPromotionItems != null) {
      data['supply_promotion_items'] =
          this.supplyPromotionItems!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Config {
  String? applyTo;
  int? minSpend;
  int? amountOff;
  String? freeSkuType;
  Null? freeProductId;
  List<Tiers>? tiers;
  List<String>? freeVariantIds;
  List<String>? appliesVariantIds;
  String? scope;
  String? category;
  int? percentOff;
  String? brand;

  Config(
      {this.applyTo,
      this.minSpend,
      this.amountOff,
      this.freeSkuType,
      this.freeProductId,
      this.tiers,
      this.freeVariantIds,
      this.appliesVariantIds,
      this.scope,
      this.category,
      this.percentOff,
      this.brand});

  Config.fromJson(Map<String, dynamic> json) {
    applyTo = json['apply_to'];
    minSpend = json['min_spend'];
    amountOff = json['amount_off'];
    freeSkuType = json['free_sku_type'];
    freeProductId = json['free_product_id'];
    if (json['tiers'] != null) {
      tiers = <Tiers>[];
      json['tiers'].forEach((v) {
        tiers!.add(new Tiers.fromJson(v));
      });
    }
    freeVariantIds = json['free_variant_ids']?.cast<String>();
    appliesVariantIds = json['applies_variant_ids']?.cast<String>();
    scope = json['scope'];
    category = json['category'];
    percentOff = json['percent_off'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apply_to'] = this.applyTo;
    data['min_spend'] = this.minSpend;
    data['amount_off'] = this.amountOff;
    data['free_sku_type'] = this.freeSkuType;
    data['free_product_id'] = this.freeProductId;
    if (this.tiers != null) {
      data['tiers'] = this.tiers!.map((v) => v.toJson()).toList();
    }
    data['free_variant_ids'] = this.freeVariantIds;
    data['applies_variant_ids'] = this.appliesVariantIds;
    data['scope'] = this.scope;
    data['category'] = this.category;
    data['percent_off'] = this.percentOff;
    data['brand'] = this.brand;
    return data;
  }
}

class Tiers {
  int? buyQty;
  int? freeQty;
  int? d;
  int? q;

  Tiers({this.buyQty, this.freeQty, this.d, this.q});

  Tiers.fromJson(Map<String, dynamic> json) {
    buyQty = json['buyQty'];
    freeQty = json['freeQty'];
    d = json['d'];
    q = json['q'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyQty'] = this.buyQty;
    data['freeQty'] = this.freeQty;
    data['d'] = this.d;
    data['q'] = this.q;
    return data;
  }
}

class SupplyPromotionItems {
  String? supplyId;
  String? itemRole;
  Supply? supply;
  String? sTypename;

  SupplyPromotionItems(
      {this.supplyId, this.itemRole, this.supply, this.sTypename});

  SupplyPromotionItems.fromJson(Map<String, dynamic> json) {
    supplyId = json['supply_id'];
    itemRole = json['item_role'];
    supply =
        json['supply'] != null ? new Supply.fromJson(json['supply']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supply_id'] = this.supplyId;
    data['item_role'] = this.itemRole;
    if (this.supply != null) {
      data['supply'] = this.supply!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supply {
  String? name;
  List<SupplyVariants>? supplyVariants;
  String? sTypename;

  Supply({this.name, this.supplyVariants, this.sTypename});

  Supply.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['supply_variants'] != null) {
      supplyVariants = <SupplyVariants>[];
      json['supply_variants'].forEach((v) {
        supplyVariants!.add(new SupplyVariants.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.supplyVariants != null) {
      data['supply_variants'] =
          this.supplyVariants!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplyVariants {
  String? id;
  String? skuCode;
  String? sTypename;

  SupplyVariants({this.id, this.skuCode, this.sTypename});

  SupplyVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuCode = json['sku_code'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku_code'] = this.skuCode;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Total {
  Aggregate? aggregate;
  String? sTypename;

  Total({this.aggregate, this.sTypename});

  Total.fromJson(Map<String, dynamic> json) {
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
