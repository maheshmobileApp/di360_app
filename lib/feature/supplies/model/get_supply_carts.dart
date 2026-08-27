class GetSupplyCarts {
  SupplyCartData? data;

  GetSupplyCarts({this.data});

  GetSupplyCarts.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplyCartData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class SupplyCartData {
  List<SupplyCarts>? supplyCarts;

  SupplyCartData({this.supplyCarts});

  SupplyCartData.fromJson(Map<String, dynamic> json) {
    if (json['supply_carts'] != null) {
      supplyCarts = [];
      json['supply_carts'].forEach((v) {
        supplyCarts?.add(new SupplyCarts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplyCarts != null) {
      data['supply_carts'] = this.supplyCarts?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplyCarts {
  String? id;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  String? supplyId;
  Supply? supply;
  String? supplyVariantId;
  SupplyVariant? supplyVariant;
  String? supplyDealId;
  int? freeQuantity;
  String? sTypename;

  SupplyCarts(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.quantity,
      this.supplyId,
      this.supply,
      this.supplyVariantId,
      this.supplyVariant,
      this.supplyDealId,
      this.freeQuantity,
      this.sTypename});

  SupplyCarts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    quantity = json['quantity'];
    supplyId = json['supply_id'];
    supply =
        json['supply'] != null ? new Supply.fromJson(json['supply']) : null;
    supplyVariantId = json['supply_variant_id'];
    supplyVariant = json['supply_variant'] != null
        ? new SupplyVariant.fromJson(json['supply_variant'])
        : null;
    supplyDealId = json['supply_deal_id'];
    freeQuantity = json['free_quantity'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['quantity'] = this.quantity;
    data['supply_id'] = this.supplyId;
    if (this.supply != null) {
      data['supply'] = this.supply?.toJson();
    }
    data['supply_variant_id'] = this.supplyVariantId;
    if (this.supplyVariant != null) {
      data['supply_variant'] = this.supplyVariant?.toJson();
    }
    data['supply_deal_id'] = this.supplyDealId;
    data['free_quantity'] = this.freeQuantity;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supply {
  String? id;
  String? name;
  String? dentalSuppliersId;
  List<Image>? image;
  DentalSupplier? dentalSupplier;
  List<Image>? jSupplyDealsSupplies;
  String? sTypename;

  Supply(
      {this.id,
      this.name,
      this.dentalSuppliersId,
      this.image,
      this.dentalSupplier,
      this.jSupplyDealsSupplies,
      this.sTypename});

  Supply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dentalSuppliersId = json['dental_suppliers_id'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(new Image.fromJson(v));
      });
    }
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    if (json['j_supply_deals_supplies'] != null) {
      jSupplyDealsSupplies = [];
      /*json['j_supply_deals_supplies'].forEach((v) {
        jSupplyDealsSupplies.add(new Null.fromJson(v));
      });*/
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dental_suppliers_id'] = this.dentalSuppliersId;
    if (this.image != null) {
      data['image'] = this.image?.map((v) => v.toJson()).toList();
    }
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier?.toJson();
    }
    if (this.jSupplyDealsSupplies != null) {
      data['j_supply_deals_supplies'] =
          this.jSupplyDealsSupplies?.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Image {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? fileType;
  String? mimeType;

  Image(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.fileType,
      this.mimeType});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    size = json['size'];
    status = json['status'];
    fileId = json['file_id'];
    isPublic = json['isPublic'];
    directory = json['directory'];
    extension = json['extension'];
    fileType = json['file_type'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['size'] = this.size;
    data['status'] = this.status;
    data['file_id'] = this.fileId;
    data['isPublic'] = this.isPublic;
    data['directory'] = this.directory;
    data['extension'] = this.extension;
    data['file_type'] = this.fileType;
    data['mime_type'] = this.mimeType;
    return data;
  }
}

class DentalSupplier {
  String? id;
  String? name;
  String? businessName;
  String? sTypename;

  DentalSupplier({this.id, this.name, this.businessName, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplyVariant {
  String? id;
  String? title;
  Null? color;
  dynamic? actualPrice;
  String? skuCode;
  dynamic? sellingPrice;
  Null? image;
  int? availableStock;
  String? sTypename;

  SupplyVariant(
      {this.id,
      this.title,
      this.color,
      this.actualPrice,
      this.skuCode,
      this.sellingPrice,
      this.image,
      this.availableStock,
      this.sTypename});

  SupplyVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = json['color'];
    actualPrice = json['actual_price'];
    skuCode = json['sku_code'];
    sellingPrice = json['selling_price'];
    image = json['image'];
    availableStock = json['available_stock'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['color'] = this.color;
    data['actual_price'] = this.actualPrice;
    data['sku_code'] = this.skuCode;
    data['selling_price'] = this.sellingPrice;
    data['image'] = this.image;
    data['available_stock'] = this.availableStock;
    data['__typename'] = this.sTypename;
    return data;
  }
}
