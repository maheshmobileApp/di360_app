class getSuppliesRes {
  getSupplyData? data;

  getSuppliesRes({this.data});

  getSuppliesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? getSupplyData.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class getSupplyData {
  List<Supplies>? supplies;

  getSupplyData({this.supplies});

  getSupplyData.fromJson(Map<String, dynamic> json) {
    if (json['supplies'] != null && json['supplies'] is List) {
      supplies = <Supplies>[];
      for (final v in json['supplies']) {
        if (v != null) {
          supplies!.add(Supplies.fromJson(v as Map<String, dynamic>));
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplies != null) {
      data['supplies'] = this.supplies?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Supplies {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  dynamic details;
  List<Image>? image;
  bool? isFeatured;
  dynamic moreImages;
  String? pageTitle;
  SeoMetadata? seoMetadata;
  String? shortId;
  String? shortInfo;
  String? sku;
  int? minStock;
  dynamic specifications;
  String? status;
  String? productStatus;
  String? supplyBrandId;
  SupplyBrand? supplyBrand;
  String? supplyCategoryId;
  String? supplySubCategoryId;
  dynamic video;
  List<SupplyVariants>? supplyVariants;
  String? dentalSuppliersId;
  DentalSupplier? dentalSupplier;
  List<JSupplyDealsSupplies>? jSupplyDealsSupplies;
  String? sTypename;

  Supplies(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.details,
      this.image,
      this.isFeatured,
      this.moreImages,
      this.pageTitle,
      this.seoMetadata,
      this.shortId,
      this.shortInfo,
      this.sku,
      this.minStock,
      this.specifications,
      this.status,
      this.productStatus,
      this.supplyBrandId,
      this.supplyBrand,
      this.supplyCategoryId,
      this.supplySubCategoryId,
      this.video,
      this.supplyVariants,
      this.dentalSuppliersId,
      this.dentalSupplier,
      this.jSupplyDealsSupplies,
      this.sTypename});

  Supplies.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    name = json['name']?.toString();
    details = json['details'];
    if (json['image'] != null && json['image'] is List) {
      image = (json['image'] as List)
          .map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    isFeatured = json['is_featured'] as bool?;
    moreImages = json['more_images'];
    pageTitle = json['page_title']?.toString();
    seoMetadata = json['seo_metadata'] != null && json['seo_metadata'] is Map
        ? SeoMetadata.fromJson(json['seo_metadata'] as Map<String, dynamic>)
        : null;
    shortId = json['short_id']?.toString();
    shortInfo = json['short_info']?.toString();
    sku = json['sku']?.toString();
    minStock = json['min_stock'] is int
        ? json['min_stock'] as int?
        : int.tryParse(json['min_stock']?.toString() ?? '');
    specifications = json['specifications'];
    status = json['status']?.toString();
    productStatus = json['product_status']?.toString();
    supplyBrandId = json['supply_brand_id']?.toString();
    supplyBrand = json['supply_brand'] != null && json['supply_brand'] is Map
        ? SupplyBrand.fromJson(json['supply_brand'] as Map<String, dynamic>)
        : null;
    supplyCategoryId = json['supply_category_id']?.toString();
    supplySubCategoryId = json['supply_sub_category_id']?.toString();
    video = json['video'];
    if (json['supply_variants'] != null && json['supply_variants'] is List) {
      supplyVariants = <SupplyVariants>[];
      for (final v in json['supply_variants']) {
        if (v != null) {
          supplyVariants!
              .add(SupplyVariants.fromJson(v as Map<String, dynamic>));
        }
      }
    }
    dentalSuppliersId = json['dental_suppliers_id']?.toString();
    dentalSupplier =
        json['dental_supplier'] != null && json['dental_supplier'] is Map
            ? DentalSupplier.fromJson(
                json['dental_supplier'] as Map<String, dynamic>)
            : null;
    if (json['j_supply_deals_supplies'] != null &&
        json['j_supply_deals_supplies'] is List) {
      jSupplyDealsSupplies = <JSupplyDealsSupplies>[];
      for (final v in json['j_supply_deals_supplies']) {
        if (v != null) {
          jSupplyDealsSupplies!
              .add(JSupplyDealsSupplies.fromJson(v as Map<String, dynamic>));
        }
      }
    }
    sTypename = json['__typename']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['details'] = this.details;
    if (image != null) {
      data['image'] = image!.map((e) => e.toJson()).toList();
    }
    data['is_featured'] = this.isFeatured;
    data['more_images'] = this.moreImages;
    data['page_title'] = this.pageTitle;
    if (this.seoMetadata != null) {
      data['seo_metadata'] = this.seoMetadata!.toJson();
    }
    data['short_id'] = this.shortId;
    data['short_info'] = this.shortInfo;
    data['sku'] = this.sku;
    data['min_stock'] = this.minStock;
    data['specifications'] = this.specifications;
    data['status'] = this.status;
    data['product_status'] = this.productStatus;
    data['supply_brand_id'] = this.supplyBrandId;
    if (this.supplyBrand != null) {
      data['supply_brand'] = this.supplyBrand?.toJson();
    }
    data['supply_category_id'] = this.supplyCategoryId;
    data['supply_sub_category_id'] = this.supplySubCategoryId;
    data['video'] = this.video;
    if (this.supplyVariants != null) {
      data['supply_variants'] =
          this.supplyVariants?.map((v) => v.toJson()).toList();
    }
    data['dental_suppliers_id'] = this.dentalSuppliersId;
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

class SeoMetadata {
  Null image;
  Null title;
  Null keywords;
  Null description;
  Null altTextOfImage;

  SeoMetadata(
      {this.image,
      this.title,
      this.keywords,
      this.description,
      this.altTextOfImage});

  SeoMetadata.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    keywords = json['keywords'];
    description = json['description'];
    altTextOfImage = json['alt_text_of_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['keywords'] = this.keywords;
    data['description'] = this.description;
    data['alt_text_of_image'] = this.altTextOfImage;
    return data;
  }
}

class SupplyBrand {
  String? id;
  String? name;
  String? sTypename;

  SupplyBrand({this.id, this.name, this.sTypename});

  SupplyBrand.fromJson(Map<String, dynamic> json) {
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

class SupplyVariants {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? actualPrice;
  String? attributes;
  int? availableStock;
  String? color;
  String? details;
  String? image;
  bool? makeDefault;
  String? moreImages;
  String? priceUnit;
  dynamic sellingPrice;
  String? specifications;
  String? status;
  String? stockUnit;
  String? supplyId;
  String? title;
  String? video;
  SupplyReviewsAggregate? supplyReviewsAggregate;
  String? sTypename;

  SupplyVariants(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.actualPrice,
      this.attributes,
      this.availableStock,
      this.color,
      this.details,
      this.image,
      this.makeDefault,
      this.moreImages,
      this.priceUnit,
      this.sellingPrice,
      this.specifications,
      this.status,
      this.stockUnit,
      this.supplyId,
      this.title,
      this.video,
      this.supplyReviewsAggregate,
      this.sTypename});

  SupplyVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    actualPrice = json['actual_price'];
    attributes = json['attributes'];
    availableStock = json['available_stock'];
    color = json['color'];
    details = json['details'];
    image = json['image'];
    makeDefault = json['make_default'];
    moreImages = json['more_images'];
    priceUnit = json['price_unit'];
    sellingPrice = json['selling_price'];
    specifications = json['specifications'];
    status = json['status'];
    stockUnit = json['stock_unit'];
    supplyId = json['supply_id'];
    title = json['title'];
    video = json['video'];
    supplyReviewsAggregate = json['supply_reviews_aggregate'] != null
        ? new SupplyReviewsAggregate.fromJson(json['supply_reviews_aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['actual_price'] = this.actualPrice;
    data['attributes'] = this.attributes;
    data['available_stock'] = this.availableStock;
    data['color'] = this.color;
    data['details'] = this.details;
    data['image'] = this.image;
    data['make_default'] = this.makeDefault;
    data['more_images'] = this.moreImages;
    data['price_unit'] = this.priceUnit;
    data['selling_price'] = this.sellingPrice;
    data['specifications'] = this.specifications;
    data['status'] = this.status;
    data['stock_unit'] = this.stockUnit;
    data['supply_id'] = this.supplyId;
    data['title'] = this.title;
    data['video'] = this.video;
    if (this.supplyReviewsAggregate != null) {
      data['supply_reviews_aggregate'] = this.supplyReviewsAggregate?.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplyReviewsAggregate {
  Aggregate? aggregate;
  String? sTypename;

  SupplyReviewsAggregate({this.aggregate, this.sTypename});

  SupplyReviewsAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate?.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Aggregate {
  int? count;
  Sum? sum;
  String? sTypename;

  Aggregate({this.count, this.sum, this.sTypename});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sum = json['sum'] != null ? new Sum.fromJson(json['sum']) : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.sum != null) {
      data['sum'] = this.sum?.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Sum {
  String? rating;
  String? sTypename;

  Sum({this.rating, this.sTypename});

  Sum.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalSupplier {
  String? id;
  String? name;
  dynamic logo;
  String? businessName;
  String? sTypename;

  DentalSupplier(
      {this.id, this.name, this.logo, this.businessName, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    logo = json['logo'];
    businessName = json['business_name']?.toString();
    sTypename = json['__typename']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.logo != null) {
      if (this.logo is Logo) {
        data['logo'] = (this.logo as Logo).toJson();
      } else {
        data['logo'] = this.logo;
      }
    }
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class JSupplyDealsSupplies {
  String? id;
  String? supplyId;
  String? supplyDealId;
  SupplyDeal? supplyDeal;
  String? sTypename;

  JSupplyDealsSupplies({
    this.id,
    this.supplyId,
    this.supplyDealId,
    this.supplyDeal,
    this.sTypename,
  });

  JSupplyDealsSupplies.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    supplyId = json['supply_id']?.toString();
    supplyDealId = json['supply_deal_id']?.toString();
    supplyDeal = json['supply_deal'] != null && json['supply_deal'] is Map
        ? SupplyDeal.fromJson(json['supply_deal'] as Map<String, dynamic>)
        : null;
    sTypename = json['__typename']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['supply_id'] = this.supplyId;
    data['supply_deal_id'] = this.supplyDealId;
    if (this.supplyDeal != null) {
      data['supply_deal'] = this.supplyDeal!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplyDeal {
  String? id;
  String? name;
  dynamic image;
  String? type;
  String? sTypename;

  SupplyDeal({this.id, this.name, this.image, this.type, this.sTypename});

  SupplyDeal.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    image = json['image'];
    type = json['type']?.toString();
    sTypename = json['__typename']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Logo {
  String? url;
  String? name;
  int? size;
  String? status;
  String? fileId;
  bool? isPublic;
  String? directory;
  String? extension;
  String? mimeType;

  Logo(
      {this.url,
      this.name,
      this.size,
      this.status,
      this.fileId,
      this.isPublic,
      this.directory,
      this.extension,
      this.mimeType});

  Logo.fromJson(Map<String, dynamic> json) {
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
