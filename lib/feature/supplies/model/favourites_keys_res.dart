class FavouritesKeysRes {
  FavouritesKeysData? data;

  FavouritesKeysRes({this.data});

  FavouritesKeysRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new FavouritesKeysData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FavouritesKeysData {
  List<SupplyFavorites>? supplyFavorites;

  FavouritesKeysData({this.supplyFavorites});

  FavouritesKeysData.fromJson(Map<String, dynamic> json) {
    if (json['supply_favorites'] != null) {
      supplyFavorites = <SupplyFavorites>[];
      json['supply_favorites'].forEach((v) {
        supplyFavorites!.add(new SupplyFavorites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplyFavorites != null) {
      data['supply_favorites'] =
          this.supplyFavorites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplyFavorites {
  String? supplyId;
  String? supplyVariantId;
  String? sTypename;

  SupplyFavorites({this.supplyId, this.supplyVariantId, this.sTypename});

  SupplyFavorites.fromJson(Map<String, dynamic> json) {
    supplyId = json['supply_id'];
    supplyVariantId = json['supply_variant_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supply_id'] = this.supplyId;
    data['supply_variant_id'] = this.supplyVariantId;
    data['__typename'] = this.sTypename;
    return data;
  }
}
