class PurchasedProductsRes {
  PurchasedProductsData? data;

  PurchasedProductsRes({this.data});

  PurchasedProductsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PurchasedProductsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PurchasedProductsData {
  List<SuppliesOrderItems>? suppliesOrderItems;

  PurchasedProductsData({this.suppliesOrderItems});

  PurchasedProductsData.fromJson(Map<String, dynamic> json) {
    if (json['supplies_order_items'] != null) {
      suppliesOrderItems = <SuppliesOrderItems>[];
      json['supplies_order_items'].forEach((v) {
        suppliesOrderItems!.add(new SuppliesOrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suppliesOrderItems != null) {
      data['supplies_order_items'] =
          this.suppliesOrderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuppliesOrderItems {
  String? id;
  String? createdAt;
  int? quantity;
  int? sentQuantity;
  double? price;
  String? supplyId;
  String? supplyVariantId;
  String? suppliesOrderId;
  Supply? supply;
  SupplyVariant? supplyVariant;
  SuppliesOrder? suppliesOrder;
  String? sTypename;

  SuppliesOrderItems(
      {this.id,
      this.createdAt,
      this.quantity,
      this.sentQuantity,
      this.price,
      this.supplyId,
      this.supplyVariantId,
      this.suppliesOrderId,
      this.supply,
      this.supplyVariant,
      this.suppliesOrder,
      this.sTypename});

  SuppliesOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    quantity = json['quantity'];
    sentQuantity = json['sent_quantity'];
    price = json['price'];
    supplyId = json['supply_id'];
    supplyVariantId = json['supply_variant_id'];
    suppliesOrderId = json['supplies_order_id'];
    supply =
        json['supply'] != null ? new Supply.fromJson(json['supply']) : null;
    supplyVariant = json['supply_variant'] != null
        ? new SupplyVariant.fromJson(json['supply_variant'])
        : null;
    suppliesOrder = json['supplies_order'] != null
        ? new SuppliesOrder.fromJson(json['supplies_order'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['quantity'] = this.quantity;
    data['sent_quantity'] = this.sentQuantity;
    data['price'] = this.price;
    data['supply_id'] = this.supplyId;
    data['supply_variant_id'] = this.supplyVariantId;
    data['supplies_order_id'] = this.suppliesOrderId;
    if (this.supply != null) {
      data['supply'] = this.supply!.toJson();
    }
    if (this.supplyVariant != null) {
      data['supply_variant'] = this.supplyVariant!.toJson();
    }
    if (this.suppliesOrder != null) {
      data['supplies_order'] = this.suppliesOrder!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supply {
  String? id;
  String? name;
  List<Image>? image;
  SupplyBrand? supplyBrand;
  SupplyBrand? supplyCategory;
  String? sTypename;

  Supply(
      {this.id,
      this.name,
      this.image,
      this.supplyBrand,
      this.supplyCategory,
      this.sTypename});

  Supply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    supplyBrand = json['supply_brand'] != null
        ? new SupplyBrand.fromJson(json['supply_brand'])
        : null;
    supplyCategory = json['supply_category'] != null
        ? new SupplyBrand.fromJson(json['supply_category'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    if (this.supplyBrand != null) {
      data['supply_brand'] = this.supplyBrand!.toJson();
    }
    if (this.supplyCategory != null) {
      data['supply_category'] = this.supplyCategory!.toJson();
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
    data['mime_type'] = this.mimeType;
    return data;
  }
}

class SupplyBrand {
  String? name;
  String? sTypename;

  SupplyBrand({this.name, this.sTypename});

  SupplyBrand.fromJson(Map<String, dynamic> json) {
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

class SupplyVariant {
  String? id;
  String? title;
  String? skuCode;
  dynamic? sellingPrice;
  dynamic? availableStock;
  Null? image;
  Null? color;
  String? sTypename;

  SupplyVariant(
      {this.id,
      this.title,
      this.skuCode,
      this.sellingPrice,
      this.availableStock,
      this.image,
      this.color,
      this.sTypename});

  SupplyVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    skuCode = json['sku_code'];
    sellingPrice = json['selling_price'];
    availableStock = json['available_stock'];
    image = json['image'];
    color = json['color'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sku_code'] = this.skuCode;
    data['selling_price'] = this.sellingPrice;
    data['available_stock'] = this.availableStock;
    data['image'] = this.image;
    data['color'] = this.color;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SuppliesOrder {
  String? id;
  String? status;
  String? createdAt;
  Null? dentalSupplierId;
  Supplier? supplier;
  String? sTypename;

  SuppliesOrder(
      {this.id,
      this.status,
      this.createdAt,
      this.dentalSupplierId,
      this.supplier,
      this.sTypename});

  SuppliesOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    dentalSupplierId = json['dental_supplier_id'];
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['dental_supplier_id'] = this.dentalSupplierId;
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supplier {
  String? id;
  String? businessName;
  String? sTypename;

  Supplier({this.id, this.businessName, this.sTypename});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
