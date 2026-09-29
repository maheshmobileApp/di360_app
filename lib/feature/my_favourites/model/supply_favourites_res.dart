class SupplyFavouritesRes {
  SupplyFavouritesData? data;

  SupplyFavouritesRes({this.data});

  SupplyFavouritesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplyFavouritesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplyFavouritesData {
  List<SupplyFavorites>? supplyFavorites;

  SupplyFavouritesData({this.supplyFavorites});

  SupplyFavouritesData.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? supplyId;
  String? supplyVariantId;
  String? createdAt;
  String? updatedAt;
  Supply? supply;
  SupplyVariant? supplyVariant;
  String? sTypename;

  SupplyFavorites(
      {this.id,
      this.supplyId,
      this.supplyVariantId,
      this.createdAt,
      this.updatedAt,
      this.supply,
      this.supplyVariant,
      this.sTypename});

  SupplyFavorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplyId = json['supply_id'];
    supplyVariantId = json['supply_variant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    supply =
        json['supply'] != null ? new Supply.fromJson(json['supply']) : null;
    supplyVariant = json['supply_variant'] != null
        ? new SupplyVariant.fromJson(json['supply_variant'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supply_id'] = this.supplyId;
    data['supply_variant_id'] = this.supplyVariantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.supply != null) {
      data['supply'] = this.supply!.toJson();
    }
    if (this.supplyVariant != null) {
      data['supply_variant'] = this.supplyVariant!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supply {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  Null? altTextOfImage;
  Null? details;
  List<Image>? image;
  bool? isFeatured;
  Null? moreImages;
  Null? pageTitle;
  SeoMetadata? seoMetadata;
  Null? shortId;
  String? shortInfo;
  Null? sku;
  Null? specifications;
  String? status;
  String? productStatus;
  String? supplyBrandId;
  SupplyBrand? supplyBrand;
  String? supplyCategoryId;
  SupplyBrand? supplyCategory;
  String? supplySubCategoryId;
  SupplyBrand? supplySubCategory;
  Null? video;
  String? dentalSuppliersId;
  DentalSupplier? dentalSupplier;
  List<Null>? jSupplyDealsSupplies;
  String? sTypename;

  Supply(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.altTextOfImage,
      this.details,
      this.image,
      this.isFeatured,
      this.moreImages,
      this.pageTitle,
      this.seoMetadata,
      this.shortId,
      this.shortInfo,
      this.sku,
      this.specifications,
      this.status,
      this.productStatus,
      this.supplyBrandId,
      this.supplyBrand,
      this.supplyCategoryId,
      this.supplyCategory,
      this.supplySubCategoryId,
      this.supplySubCategory,
      this.video,
      this.dentalSuppliersId,
      this.dentalSupplier,
      this.jSupplyDealsSupplies,
      this.sTypename});

  Supply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    altTextOfImage = json['alt_text_of_image'];
    details = json['details'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    isFeatured = json['is_featured'];
    moreImages = json['more_images'];
    pageTitle = json['page_title'];
    seoMetadata = json['seo_metadata'] != null
        ? new SeoMetadata.fromJson(json['seo_metadata'])
        : null;
    shortId = json['short_id'];
    shortInfo = json['short_info'];
    sku = json['sku'];
    specifications = json['specifications'];
    status = json['status'];
    productStatus = json['product_status'];
    supplyBrandId = json['supply_brand_id'];
    supplyBrand = json['supply_brand'] != null
        ? new SupplyBrand.fromJson(json['supply_brand'])
        : null;
    supplyCategoryId = json['supply_category_id'];
    supplyCategory = json['supply_category'] != null
        ? new SupplyBrand.fromJson(json['supply_category'])
        : null;
    supplySubCategoryId = json['supply_sub_category_id'];
    supplySubCategory = json['supply_sub_category'] != null
        ? new SupplyBrand.fromJson(json['supply_sub_category'])
        : null;
    video = json['video'];
    dentalSuppliersId = json['dental_suppliers_id'];
    dentalSupplier = json['dental_supplier'] != null
        ? new DentalSupplier.fromJson(json['dental_supplier'])
        : null;
    
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['alt_text_of_image'] = this.altTextOfImage;
    data['details'] = this.details;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
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
    data['specifications'] = this.specifications;
    data['status'] = this.status;
    data['product_status'] = this.productStatus;
    data['supply_brand_id'] = this.supplyBrandId;
    if (this.supplyBrand != null) {
      data['supply_brand'] = this.supplyBrand!.toJson();
    }
    data['supply_category_id'] = this.supplyCategoryId;
    if (this.supplyCategory != null) {
      data['supply_category'] = this.supplyCategory!.toJson();
    }
    data['supply_sub_category_id'] = this.supplySubCategoryId;
    if (this.supplySubCategory != null) {
      data['supply_sub_category'] = this.supplySubCategory!.toJson();
    }
    data['video'] = this.video;
    data['dental_suppliers_id'] = this.dentalSuppliersId;
    if (this.dentalSupplier != null) {
      data['dental_supplier'] = this.dentalSupplier!.toJson();
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
  Null? image;
  Null? title;
  Null? keywords;
  Null? description;
  Null? altTextOfImage;

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

class DentalSupplier {
  String? id;
  String? name;
  Logo? logo;
  String? businessName;
  String? sTypename;

  DentalSupplier(
      {this.id, this.name, this.logo, this.businessName, this.sTypename});

  DentalSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['business_name'] = this.businessName;
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

class SupplyVariant {
  String? id;
  String? createdAt;
  String? updatedAt;
  Null? actualPrice;
  Null? attributes;
  String? skuCode;
  int? availableStock;
  Null? color;
  Null? details;
  Null? image;
  bool? makeDefault;
  Null? moreImages;
  String? priceUnit;
  dynamic? sellingPrice;
  Null? specifications;
  String? status;
  Null? stockUnit;
  String? supplyId;
  String? title;
  Null? video;
  SupplyReviewsAggregate? supplyReviewsAggregate;
  String? sTypename;

  SupplyVariant(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.actualPrice,
      this.attributes,
      this.skuCode,
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

  SupplyVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    actualPrice = json['actual_price'];
    attributes = json['attributes'];
    skuCode = json['sku_code'];
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
    data['sku_code'] = this.skuCode;
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
      data['supply_reviews_aggregate'] = this.supplyReviewsAggregate!.toJson();
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
      data['aggregate'] = this.aggregate!.toJson();
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
      data['sum'] = this.sum!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Sum {
  Null? rating;
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
