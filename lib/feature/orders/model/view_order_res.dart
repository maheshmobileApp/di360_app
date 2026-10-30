import 'package:di360_flutter/feature/my_orders/model/view_order_res.dart';

class ViewOrderDetailsRes {
  ViewOrderData? data;

  ViewOrderDetailsRes({this.data});

  ViewOrderDetailsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ViewOrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ViewOrderData {
  SuppliesOrdersByPk? suppliesOrdersByPk;

  ViewOrderData({this.suppliesOrdersByPk});

  ViewOrderData.fromJson(Map<String, dynamic> json) {
    suppliesOrdersByPk = json['supplies_orders_by_pk'] != null
        ? new SuppliesOrdersByPk.fromJson(json['supplies_orders_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suppliesOrdersByPk != null) {
      data['supplies_orders_by_pk'] = this.suppliesOrdersByPk!.toJson();
    }
    return data;
  }
}

class SuppliesOrdersByPk {
  String? id;
  String? createdAt;
  int? totalAmount;
  int? subTotal;
  int? couponDiscount;
  int? deliveryCharge;
  int? taxAmount;
  int? taxPercentage;
  String? status;
  bool? isConfirmed;
  int? orderNumber;
  DentalPractice? dentalPractice;
  DentalPractice? dentalProfessional;
  ShippingAddress? shippingAddress;
  List<SuppliesOrderItems>? suppliesOrderItems;
  List<Null>? supplyDispatch;
  List<Null>? suppliesOrderHistory;
  String? sTypename;

  SuppliesOrdersByPk(
      {this.id,
      this.createdAt,
      this.totalAmount,
      this.subTotal,
      this.couponDiscount,
      this.deliveryCharge,
      this.taxAmount,
      this.taxPercentage,
      this.status,
      this.isConfirmed,
      this.orderNumber,
      this.dentalPractice,
      this.dentalProfessional,
      this.shippingAddress,
      this.suppliesOrderItems,
      this.supplyDispatch,
      this.suppliesOrderHistory,
      this.sTypename});

  SuppliesOrdersByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    totalAmount = json['total_amount'];
    subTotal = json['sub_total'];
    couponDiscount = json['coupon_discount'];
    deliveryCharge = json['delivery_charge'];
    taxAmount = json['tax_amount'];
    taxPercentage = json['tax_percentage'];
    status = json['status'];
    isConfirmed = json['is_confirmed'];
    orderNumber = json['order_number'];
    dentalPractice = json['dental_practice'] != null
        ? new DentalPractice.fromJson(json['dental_practice'])
        : null;
    dentalProfessional = json['dental_professional'] != null
        ? new DentalPractice.fromJson(json['dental_professional'])
        : null;
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    if (json['supplies_order_items'] != null) {
      suppliesOrderItems = <SuppliesOrderItems>[];
      json['supplies_order_items'].forEach((v) {
        suppliesOrderItems!.add(new SuppliesOrderItems.fromJson(v));
      });
    }
    
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['total_amount'] = this.totalAmount;
    data['sub_total'] = this.subTotal;
    data['coupon_discount'] = this.couponDiscount;
    data['delivery_charge'] = this.deliveryCharge;
    data['tax_amount'] = this.taxAmount;
    data['tax_percentage'] = this.taxPercentage;
    data['status'] = this.status;
    data['is_confirmed'] = this.isConfirmed;
    data['order_number'] = this.orderNumber;
    if (this.dentalPractice != null) {
      data['dental_practice'] = this.dentalPractice!.toJson();
    }
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.suppliesOrderItems != null) {
      data['supplies_order_items'] =
          this.suppliesOrderItems!.map((v) => v.toJson()).toList();
    }
   
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalPractice {
  String? id;
  String? name;
  String? businessName;
  int? zipcode;
  String? state;
  String? city;
  String? addressLineOne;
  String? addressLineTwo;
  String? landMark;
  String? sTypename;

  DentalPractice(
      {this.id,
      this.name,
      this.businessName,
      this.zipcode,
      this.state,
      this.city,
      this.addressLineOne,
      this.addressLineTwo,
      this.landMark,
      this.sTypename});

  DentalPractice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    businessName = json['business_name'];
    zipcode = json['zipcode'];
    state = json['state'];
    city = json['city'];
    addressLineOne = json['address_line_one'];
    addressLineTwo = json['address_line_two'];
    landMark = json['land_mark'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['business_name'] = this.businessName;
    data['zipcode'] = this.zipcode;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address_line_one'] = this.addressLineOne;
    data['address_line_two'] = this.addressLineTwo;
    data['land_mark'] = this.landMark;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class ShippingAddress {
  String? id;
  String? city;
  String? type;
  String? state;
  String? line1;
  Null? line2;
  String? country;
  String? landmark;
  double? latitude;
  double? longitude;
  String? sTypename;
  String? createdAt;
  String? shortName;
  String? updatedAt;
  String? postalCode;
  bool? makeDefault;
  String? googlePlaceId;
  Null? otherTypeName;
  Null? dentalProfessionalId;

  ShippingAddress(
      {this.id,
      this.city,
      this.type,
      this.state,
      this.line1,
      this.line2,
      this.country,
      this.landmark,
      this.latitude,
      this.longitude,
      this.sTypename,
      this.createdAt,
      this.shortName,
      this.updatedAt,
      this.postalCode,
      this.makeDefault,
      this.googlePlaceId,
      this.otherTypeName,
      this.dentalProfessionalId});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    type = json['type'];
    state = json['state'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    country = json['country'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    sTypename = json['__typename'];
    createdAt = json['created_at'];
    shortName = json['short_name'];
    updatedAt = json['updated_at'];
    postalCode = json['postal_code'];
    makeDefault = json['make_default'];
    googlePlaceId = json['google_place_id'];
    otherTypeName = json['other_type_name'];
    dentalProfessionalId = json['dental_professional_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['type'] = this.type;
    data['state'] = this.state;
    data['line_1'] = this.line1;
    data['line_2'] = this.line2;
    data['country'] = this.country;
    data['landmark'] = this.landmark;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['__typename'] = this.sTypename;
    data['created_at'] = this.createdAt;
    data['short_name'] = this.shortName;
    data['updated_at'] = this.updatedAt;
    data['postal_code'] = this.postalCode;
    data['make_default'] = this.makeDefault;
    data['google_place_id'] = this.googlePlaceId;
    data['other_type_name'] = this.otherTypeName;
    data['dental_professional_id'] = this.dentalProfessionalId;
    return data;
  }
}

/*class SuppliesOrderItems {
  String? id;
  int? quantity;
  int? price;
  int? freeQuantity;
  String? status;
  Supply? supply;
  SupplyVariant? supplyVariant;
  List<Null>? supplyDispatchItems;
  String? sTypename;

  SuppliesOrderItems(
      {this.id,
      this.quantity,
      this.price,
      this.freeQuantity,
      this.status,
      this.supply,
      this.supplyVariant,
      this.supplyDispatchItems,
      this.sTypename});

  SuppliesOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    freeQuantity = json['free_quantity'];
    status = json['status'];
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
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['free_quantity'] = this.freeQuantity;
    data['status'] = this.status;
    if (this.supply != null) {
      data['supply'] = this.supply!.toJson();
    }
    if (this.supplyVariant != null) {
      data['supply_variant'] = this.supplyVariant!.toJson();
    }
    
    data['__typename'] = this.sTypename;
    return data;
  }
}*/

class Supply {
  String? name;
  String? priceType;
  String? sTypename;

  Supply({this.name, this.priceType, this.sTypename});

  Supply.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    priceType = json['price_type'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price_type'] = this.priceType;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SupplyVariant {
  Null? title;
  String? skuCode;
  Null? color;
  Null? image;
  int? sellingPrice;
  int? calculatedPrice;
  String? sTypename;

  SupplyVariant(
      {this.title,
      this.skuCode,
      this.color,
      this.image,
      this.sellingPrice,
      this.calculatedPrice,
      this.sTypename});

  SupplyVariant.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    skuCode = json['sku_code'];
    color = json['color'];
    image = json['image'];
    sellingPrice = json['selling_price'];
    calculatedPrice = json['calculated_price'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sku_code'] = this.skuCode;
    data['color'] = this.color;
    data['image'] = this.image;
    data['selling_price'] = this.sellingPrice;
    data['calculated_price'] = this.calculatedPrice;
    data['__typename'] = this.sTypename;
    return data;
  }
}
