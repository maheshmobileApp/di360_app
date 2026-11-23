class SuppliesDetailsRes {
  SuppliesDetailData? data;

  SuppliesDetailsRes({this.data});

  SuppliesDetailsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SuppliesDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SuppliesDetailData {
  SuppliesByPk? suppliesByPk;

  SuppliesDetailData({this.suppliesByPk});

  SuppliesDetailData.fromJson(Map<String, dynamic> json) {
    suppliesByPk = json['supplies_by_pk'] != null
        ? new SuppliesByPk.fromJson(json['supplies_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suppliesByPk != null) {
      data['supplies_by_pk'] = this.suppliesByPk!.toJson();
    }
    return data;
  }
}

class SuppliesByPk {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  Null? altTextOfImage;
  Null? details;
  List<Image>? image;
  bool? isFeatured;
  List<dynamic>? moreImages;
  Null? pageTitle;
  int? minStock;
  SeoMetadata? seoMetadata;
  String? productType;
  String? productCondition;
  Null? docMsds;
  Null? docManual;
  Null? docWarranty;
  Null? docSpecSheet;
  Null? docBrochure;
  Null? shortId;
  String? shortInfo;
  Null? sku;
  Null? gstApplicable;
  dynamic? gstRate;
  String? priceType;
  Null? specifications;
  String? status;
  String? productStatus;
  String? supplyBrandId;
  Null? otherBrandName;
  Null? deal;
  SupplyBrand? supplyBrand;
  String? supplyCategoryId;
  Null? otherCategoryName;
  SupplyBrand? supplyCategory;
  String? supplySubCategoryId;
  Null? otherSubCategoryName;
  SupplyBrand? supplySubCategory;
  Null? video;
  List<SupplyVariants>? supplyVariants;
  List<Null>? tags;
  List<Null>? supplyReviews;
  String? sTypename;

  SuppliesByPk(
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
      this.minStock,
      this.seoMetadata,
      this.productType,
      this.productCondition,
      this.docMsds,
      this.docManual,
      this.docWarranty,
      this.docSpecSheet,
      this.docBrochure,
      this.shortId,
      this.shortInfo,
      this.sku,
      this.gstApplicable,
      this.gstRate,
      this.priceType,
      this.specifications,
      this.status,
      this.productStatus,
      this.supplyBrandId,
      this.otherBrandName,
      this.deal,
      this.supplyBrand,
      this.supplyCategoryId,
      this.otherCategoryName,
      this.supplyCategory,
      this.supplySubCategoryId,
      this.otherSubCategoryName,
      this.supplySubCategory,
      this.video,
      this.supplyVariants,
      this.tags,
      this.supplyReviews,
      this.sTypename});

  SuppliesByPk.fromJson(Map<String, dynamic> json) {
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
    
    pageTitle = json['page_title'];
    minStock = json['min_stock'];
    seoMetadata = json['seo_metadata'] != null
        ? new SeoMetadata.fromJson(json['seo_metadata'])
        : null;
    productType = json['product_type'];
    productCondition = json['product_condition'];
    docMsds = json['doc_msds'];
    docManual = json['doc_manual'];
    docWarranty = json['doc_warranty'];
    docSpecSheet = json['doc_spec_sheet'];
    docBrochure = json['doc_brochure'];
    shortId = json['short_id'];
    shortInfo = json['short_info'];
    sku = json['sku'];
    gstApplicable = json['gst_applicable'];
    gstRate = json['gst_rate'];
    priceType = json['price_type'];
    specifications = json['specifications'];
    status = json['status'];
    productStatus = json['product_status'];
    supplyBrandId = json['supply_brand_id'];
    otherBrandName = json['other_brand_name'];
    deal = json['deal'];
    supplyBrand = json['supply_brand'] != null
        ? new SupplyBrand.fromJson(json['supply_brand'])
        : null;
    supplyCategoryId = json['supply_category_id'];
    otherCategoryName = json['other_category_name'];
    supplyCategory = json['supply_category'] != null
        ? new SupplyBrand.fromJson(json['supply_category'])
        : null;
    supplySubCategoryId = json['supply_sub_category_id'];
    otherSubCategoryName = json['other_sub_category_name'];
    supplySubCategory = json['supply_sub_category'] != null
        ? new SupplyBrand.fromJson(json['supply_sub_category'])
        : null;
    video = json['video'];
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
    if (this.moreImages != null) {
      data['more_images'] = this.moreImages!.map((v) => v.toJson()).toList();
    }
    data['page_title'] = this.pageTitle;
    data['min_stock'] = this.minStock;
    if (this.seoMetadata != null) {
      data['seo_metadata'] = this.seoMetadata!.toJson();
    }
    data['product_type'] = this.productType;
    data['product_condition'] = this.productCondition;
    data['doc_msds'] = this.docMsds;
    data['doc_manual'] = this.docManual;
    data['doc_warranty'] = this.docWarranty;
    data['doc_spec_sheet'] = this.docSpecSheet;
    data['doc_brochure'] = this.docBrochure;
    data['short_id'] = this.shortId;
    data['short_info'] = this.shortInfo;
    data['sku'] = this.sku;
    data['gst_applicable'] = this.gstApplicable;
    data['gst_rate'] = this.gstRate;
    data['price_type'] = this.priceType;
    data['specifications'] = this.specifications;
    data['status'] = this.status;
    data['product_status'] = this.productStatus;
    data['supply_brand_id'] = this.supplyBrandId;
    data['other_brand_name'] = this.otherBrandName;
    data['deal'] = this.deal;
    if (this.supplyBrand != null) {
      data['supply_brand'] = this.supplyBrand!.toJson();
    }
    data['supply_category_id'] = this.supplyCategoryId;
    data['other_category_name'] = this.otherCategoryName;
    if (this.supplyCategory != null) {
      data['supply_category'] = this.supplyCategory!.toJson();
    }
    data['supply_sub_category_id'] = this.supplySubCategoryId;
    data['other_sub_category_name'] = this.otherSubCategoryName;
    if (this.supplySubCategory != null) {
      data['supply_sub_category'] = this.supplySubCategory!.toJson();
    }
    data['video'] = this.video;
    if (this.supplyVariants != null) {
      data['supply_variants'] =
          this.supplyVariants!.map((v) => v.toJson()).toList();
    }
    
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Image {
  String? url;

  Image({this.url});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
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

class SupplyVariants {
  String? id;
  String? createdAt;
  String? updatedAt;
  Null? actualPrice;
  Null? attributes;
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
  String? skuCode;
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
      this.skuCode,
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
    skuCode = json['sku_code'];
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
    data['sku_code'] = this.skuCode;
    data['__typename'] = this.sTypename;
    return data;
  }
}
