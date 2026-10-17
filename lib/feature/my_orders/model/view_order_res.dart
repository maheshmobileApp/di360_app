class ViewOrderRes {
  ViewOrderData? data;

  ViewOrderRes({this.data});

  ViewOrderRes.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new ViewOrderData.fromJson(json['data']) : null;
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
  String? updatedAt;
  Null? shortId;
  Null? supplyCouponId;
  dynamic? totalAmount;
  dynamic? taxAmount;
  dynamic? taxPercentage;
  dynamic? deliveryCharge;
  dynamic? estimatedDeliveryInDays;
  String? status;
  bool? isConfirmed;
  String? paymentStatus;
  String? paymentMode;
  BillingAddress? billingAddress;
  BillingAddress? shippingAddress;
  Null? onlinePaymentOrderId;
  Null? onlinePaymentTransactionId;
  String? onlinePaymentSignature;
  String? approvedOn;
  String? approvedMessage;
  String? shippedOn;
  String? shippedMessage;
  String? deliveredOn;
  String? deliveredMessage;
  String? cancelledOn;
  String? canceledMessage;
  String? refundedOn;
  String? refundedMessage;
  String? customMessage;
  String? dentalPracticeId;
  DentalPractice? dentalPractice;
  String? dentalProfessionalId;
  DentalProfessional? dentalProfessional;
  Null? dentalSupplierId;
  Null? dentalSupplier;
  AccountPayDetails? accountPayDetails;
  String? suppliersId;
  Supplier? supplier;
  dynamic? couponDiscount;
  dynamic? subTotal;
  dynamic? orderNumber;
  List<SuppliesOrderItems>? suppliesOrderItems;
  List<Null>? supplyDispatch;
  List<SuppliesOrderHistory>? suppliesOrderHistory;
  List<SuppliesOrderNotes>? suppliesOrderNotes;
  String? sTypename;

  SuppliesOrdersByPk(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.shortId,
      this.supplyCouponId,
      this.totalAmount,
      this.taxAmount,
      this.taxPercentage,
      this.deliveryCharge,
      this.estimatedDeliveryInDays,
      this.status,
      this.isConfirmed,
      this.paymentStatus,
      this.paymentMode,
      this.billingAddress,
      this.shippingAddress,
      this.onlinePaymentOrderId,
      this.onlinePaymentTransactionId,
      this.onlinePaymentSignature,
      this.approvedOn,
      this.approvedMessage,
      this.shippedOn,
      this.shippedMessage,
      this.deliveredOn,
      this.deliveredMessage,
      this.cancelledOn,
      this.canceledMessage,
      this.refundedOn,
      this.refundedMessage,
      this.customMessage,
      this.dentalPracticeId,
      this.dentalPractice,
      this.dentalProfessionalId,
      this.dentalProfessional,
      this.dentalSupplierId,
      this.dentalSupplier,
      this.accountPayDetails,
      this.suppliersId,
      this.supplier,
      this.couponDiscount,
      this.subTotal,
      this.orderNumber,
      this.suppliesOrderItems,
      this.supplyDispatch,
      this.suppliesOrderHistory,
      this.suppliesOrderNotes,
      this.sTypename});

  SuppliesOrdersByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shortId = json['short_id'];
    supplyCouponId = json['supply_coupon_id'];
    totalAmount = json['total_amount'];
    taxAmount = json['tax_amount'];
    taxPercentage = json['tax_percentage'];
    deliveryCharge = json['delivery_charge'];
    estimatedDeliveryInDays = json['estimated_delivery_in_days'];
    status = json['status'];
    isConfirmed = json['is_confirmed'];
    paymentStatus = json['payment_status'];
    paymentMode = json['payment_mode'];
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    shippingAddress = json['shipping_address'] != null
        ? new BillingAddress.fromJson(json['shipping_address'])
        : null;
    onlinePaymentOrderId = json['online_payment_order_id'];
    onlinePaymentTransactionId = json['online_payment_transaction_id'];
    onlinePaymentSignature = json['online_payment_signature'];
    approvedOn = json['approved_on'];
    approvedMessage = json['approved_message'];
    shippedOn = json['shipped_on'];
    shippedMessage = json['shipped_message'];
    deliveredOn = json['delivered_on'];
    deliveredMessage = json['delivered_message'];
    cancelledOn = json['cancelled_on'];
    canceledMessage = json['canceled_message'];
    refundedOn = json['refunded_on'];
    refundedMessage = json['refunded_message'];
    customMessage = json['custom_message'];
    dentalPracticeId = json['dental_practice_id'];
    dentalPractice = json['dental_practice'] != null
        ? new DentalPractice.fromJson(json['dental_practice'])
        : null;
    dentalProfessionalId = json['dental_professional_id'];
    dentalProfessional = json['dental_professional'] != null
        ? new DentalProfessional.fromJson(json['dental_professional'])
        : null;
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'];
    accountPayDetails = json['account_pay_details'] != null
        ? new AccountPayDetails.fromJson(json['account_pay_details'])
        : null;
    suppliersId = json['suppliers_id'];
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
    couponDiscount = json['coupon_discount'];
    subTotal = json['sub_total'];
    orderNumber = json['order_number'];
    if (json['supplies_order_items'] != null) {
      suppliesOrderItems = <SuppliesOrderItems>[];
      json['supplies_order_items'].forEach((v) {
        suppliesOrderItems!.add(new SuppliesOrderItems.fromJson(v));
      });
    }

    supplyDispatch = <Null>[];

    if (json['supplies_order_history'] != null) {
      suppliesOrderHistory = <SuppliesOrderHistory>[];
      json['supplies_order_history'].forEach((v) {
        suppliesOrderHistory!.add(new SuppliesOrderHistory.fromJson(v));
      });
    }
    if (json['supplies_order_notes'] != null) {
      suppliesOrderNotes = <SuppliesOrderNotes>[];
      json['supplies_order_notes'].forEach((v) {
        suppliesOrderNotes!.add(new SuppliesOrderNotes.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['short_id'] = this.shortId;
    data['supply_coupon_id'] = this.supplyCouponId;
    data['total_amount'] = this.totalAmount;
    data['tax_amount'] = this.taxAmount;
    data['tax_percentage'] = this.taxPercentage;
    data['delivery_charge'] = this.deliveryCharge;
    data['estimated_delivery_in_days'] = this.estimatedDeliveryInDays;
    data['status'] = this.status;
    data['is_confirmed'] = this.isConfirmed;
    data['payment_status'] = this.paymentStatus;
    data['payment_mode'] = this.paymentMode;
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress!.toJson();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    data['online_payment_order_id'] = this.onlinePaymentOrderId;
    data['online_payment_transaction_id'] = this.onlinePaymentTransactionId;
    data['online_payment_signature'] = this.onlinePaymentSignature;
    data['approved_on'] = this.approvedOn;
    data['approved_message'] = this.approvedMessage;
    data['shipped_on'] = this.shippedOn;
    data['shipped_message'] = this.shippedMessage;
    data['delivered_on'] = this.deliveredOn;
    data['delivered_message'] = this.deliveredMessage;
    data['cancelled_on'] = this.cancelledOn;
    data['canceled_message'] = this.canceledMessage;
    data['refunded_on'] = this.refundedOn;
    data['refunded_message'] = this.refundedMessage;
    data['custom_message'] = this.customMessage;
    data['dental_practice_id'] = this.dentalPracticeId;
    if (this.dentalPractice != null) {
      data['dental_practice'] = this.dentalPractice!.toJson();
    }
    data['dental_professional_id'] = this.dentalProfessionalId;
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['dental_supplier'] = this.dentalSupplier;
    if (this.accountPayDetails != null) {
      data['account_pay_details'] = this.accountPayDetails!.toJson();
    }
    data['suppliers_id'] = this.suppliersId;
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    data['coupon_discount'] = this.couponDiscount;
    data['sub_total'] = this.subTotal;
    data['order_number'] = this.orderNumber;
    if (this.suppliesOrderItems != null) {
      data['supplies_order_items'] =
          this.suppliesOrderItems!.map((v) => v.toJson()).toList();
    }

    data['supply_dispatch'] = [];

    if (this.suppliesOrderHistory != null) {
      data['supplies_order_history'] =
          this.suppliesOrderHistory!.map((v) => v.toJson()).toList();
    }
    if (this.suppliesOrderNotes != null) {
      data['supplies_order_notes'] =
          this.suppliesOrderNotes!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class BillingAddress {
  String? id;
  String? city;
  String? type;
  String? state;
  String? line1;
  String? line2;
  String? country;
  String? landmark;
  dynamic? latitude;
  dynamic? longitude;
  String? sTypename;
  String? createdAt;
  String? shortName;
  String? updatedAt;
  String? postalCode;
  bool? makeDefault;
  String? googlePlaceId;
  String? otherTypeName;
  String? dentalProfessionalId;

  BillingAddress(
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

  BillingAddress.fromJson(Map<String, dynamic> json) {
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

class DentalProfessional {
  String? id;
  String? name;
  String? phone;
  String? sTypename;

  DentalProfessional({this.id, this.name, this.phone, this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class DentalPractice {
  String? id;
  String? name;
  String? phone;
  String? sTypename;

  DentalPractice({this.id, this.name, this.phone, this.sTypename});

  DentalPractice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class AccountPayDetails {
  String? email;
  Null? newAbn;
  Null? newNotes;
  Null? newPhone;
  String? clinicName;
  String? companyName;
  String? paymentMode;
  String? accountNumber;
  Null? newPracticeName;
  Null? newContactPerson;
  Null? newBillingAddress;

  AccountPayDetails(
      {this.email,
      this.newAbn,
      this.newNotes,
      this.newPhone,
      this.clinicName,
      this.companyName,
      this.paymentMode,
      this.accountNumber,
      this.newPracticeName,
      this.newContactPerson,
      this.newBillingAddress});

  AccountPayDetails.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    newAbn = json['new_abn'];
    newNotes = json['new_notes'];
    newPhone = json['new_phone'];
    clinicName = json['clinic_name'];
    companyName = json['company_name'];
    paymentMode = json['payment_mode'];
    accountNumber = json['account_number'];
    newPracticeName = json['new_practice_name'];
    newContactPerson = json['new_contact_person'];
    newBillingAddress = json['new_billing_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['new_abn'] = this.newAbn;
    data['new_notes'] = this.newNotes;
    data['new_phone'] = this.newPhone;
    data['clinic_name'] = this.clinicName;
    data['company_name'] = this.companyName;
    data['payment_mode'] = this.paymentMode;
    data['account_number'] = this.accountNumber;
    data['new_practice_name'] = this.newPracticeName;
    data['new_contact_person'] = this.newContactPerson;
    data['new_billing_address'] = this.newBillingAddress;
    return data;
  }
}

class Supplier {
  String? id;
  String? name;
  Logo? logo;
  String? businessName;
  String? email;
  String? phone;
  String? sTypename;

  Supplier(
      {this.id,
      this.name,
      this.logo,
      this.businessName,
      this.email,
      this.phone,
      this.sTypename});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    businessName = json['business_name'];
    email = json['email'];
    phone = json['phone'];
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
    data['email'] = this.email;
    data['phone'] = this.phone;
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

class SuppliesOrderItems {
  String? id;
  String? createdAt;
  dynamic? price;
  dynamic? quantity;
  String? suppliesOrderId;
  String? supplyId;
  dynamic? sentQuantity;
  String? status;
  Supply? supply;
  Null? supplyDealId;
  Null? supplyDeal;
  dynamic? freeQuantity;
  Null? supplyVariantAttributes;
  String? supplyVariantId;
  SupplyVariant? supplyVariant;
  String? updatedAt;
  String? sTypename;

  SuppliesOrderItems(
      {this.id,
      this.createdAt,
      this.price,
      this.quantity,
      this.suppliesOrderId,
      this.supplyId,
      this.sentQuantity,
      this.status,
      this.supply,
      this.supplyDealId,
      this.supplyDeal,
      this.freeQuantity,
      this.supplyVariantAttributes,
      this.supplyVariantId,
      this.supplyVariant,
      this.updatedAt,
      this.sTypename});

  SuppliesOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    price = json['price'];
    quantity = json['quantity'];
    suppliesOrderId = json['supplies_order_id'];
    supplyId = json['supply_id'];
    sentQuantity = json['sent_quantity'];
    status = json['status'];
    supply =
        json['supply'] != null ? new Supply.fromJson(json['supply']) : null;
    supplyDealId = json['supply_deal_id'];
    supplyDeal = json['supply_deal'];
    freeQuantity = json['free_quantity'];
    supplyVariantAttributes = json['supply_variant_attributes'];
    supplyVariantId = json['supply_variant_id'];
    supplyVariant = json['supply_variant'] != null
        ? new SupplyVariant.fromJson(json['supply_variant'])
        : null;
    updatedAt = json['updated_at'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['supplies_order_id'] = this.suppliesOrderId;
    data['supply_id'] = this.supplyId;
    data['sent_quantity'] = this.sentQuantity;
    data['status'] = this.status;
    if (this.supply != null) {
      data['supply'] = this.supply!.toJson();
    }
    data['supply_deal_id'] = this.supplyDealId;
    data['supply_deal'] = this.supplyDeal;
    data['free_quantity'] = this.freeQuantity;
    data['supply_variant_attributes'] = this.supplyVariantAttributes;
    data['supply_variant_id'] = this.supplyVariantId;
    if (this.supplyVariant != null) {
      data['supply_variant'] = this.supplyVariant!.toJson();
    }
    data['updated_at'] = this.updatedAt;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supply {
  String? id;
  String? name;
  String? sTypename;

  Supply({this.id, this.name, this.sTypename});

  Supply.fromJson(Map<String, dynamic> json) {
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

class SupplyVariant {
  String? id;
  Null? title;
  Null? actualPrice;
  Null? attributes;
  dynamic? availableStock;
  Null? color;
  String? createdAt;
  Null? details;
  Null? image;
  String? skuCode;
  dynamic? sellingPrice;
  Null? stockUnit;
  String? priceUnit;
  bool? makeDefault;
  SupplyReviewsAggregate? supplyReviewsAggregate;
  String? sTypename;

  SupplyVariant(
      {this.id,
      this.title,
      this.actualPrice,
      this.attributes,
      this.availableStock,
      this.color,
      this.createdAt,
      this.details,
      this.image,
      this.skuCode,
      this.sellingPrice,
      this.stockUnit,
      this.priceUnit,
      this.makeDefault,
      this.supplyReviewsAggregate,
      this.sTypename});

  SupplyVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    actualPrice = json['actual_price'];
    attributes = json['attributes'];
    availableStock = json['available_stock'];
    color = json['color'];
    createdAt = json['created_at'];
    details = json['details'];
    image = json['image'];
    skuCode = json['sku_code'];
    sellingPrice = json['selling_price'];
    stockUnit = json['stock_unit'];
    priceUnit = json['price_unit'];
    makeDefault = json['make_default'];
    supplyReviewsAggregate = json['supply_reviews_aggregate'] != null
        ? new SupplyReviewsAggregate.fromJson(json['supply_reviews_aggregate'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['actual_price'] = this.actualPrice;
    data['attributes'] = this.attributes;
    data['available_stock'] = this.availableStock;
    data['color'] = this.color;
    data['created_at'] = this.createdAt;
    data['details'] = this.details;
    data['image'] = this.image;
    data['sku_code'] = this.skuCode;
    data['selling_price'] = this.sellingPrice;
    data['stock_unit'] = this.stockUnit;
    data['price_unit'] = this.priceUnit;
    data['make_default'] = this.makeDefault;
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

class SuppliesOrderHistory {
  String? id;
  String? eventType;
  String? statusSnapshot;
  Null? invoiceNumber;
  Null? postalService;
  Null? trackingNumber;
  Null? supplyDispatchId;
  Null? versionNumber;
  String? createdAt;
  String? sTypename;

  SuppliesOrderHistory(
      {this.id,
      this.eventType,
      this.statusSnapshot,
      this.invoiceNumber,
      this.postalService,
      this.trackingNumber,
      this.supplyDispatchId,
      this.versionNumber,
      this.createdAt,
      this.sTypename});

  SuppliesOrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventType = json['event_type'];
    statusSnapshot = json['status_snapshot'];
    invoiceNumber = json['invoice_number'];
    postalService = json['postal_service'];
    trackingNumber = json['tracking_number'];
    supplyDispatchId = json['supply_dispatch_id'];
    versionNumber = json['version_number'];
    createdAt = json['created_at'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_type'] = this.eventType;
    data['status_snapshot'] = this.statusSnapshot;
    data['invoice_number'] = this.invoiceNumber;
    data['postal_service'] = this.postalService;
    data['tracking_number'] = this.trackingNumber;
    data['supply_dispatch_id'] = this.supplyDispatchId;
    data['version_number'] = this.versionNumber;
    data['created_at'] = this.createdAt;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SuppliesOrderNotes {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? suppliesOrderId;
  String? status;
  String? message;
  Null? extra;
  String? sTypename;

  SuppliesOrderNotes(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.suppliesOrderId,
      this.status,
      this.message,
      this.extra,
      this.sTypename});

  SuppliesOrderNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    suppliesOrderId = json['supplies_order_id'];
    status = json['status'];
    message = json['message'];
    extra = json['extra'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['supplies_order_id'] = this.suppliesOrderId;
    data['status'] = this.status;
    data['message'] = this.message;
    data['extra'] = this.extra;
    data['__typename'] = this.sTypename;
    return data;
  }
}
