class SuppliesOrdersRes {
  SuppliesOrdersData? data;

  SuppliesOrdersRes({this.data});

  SuppliesOrdersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SuppliesOrdersData.fromJson(json['data'])
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

class SuppliesOrdersData {
  List<SuppliesOrders>? suppliesOrders;

  SuppliesOrdersData({this.suppliesOrders});

  SuppliesOrdersData.fromJson(Map<String, dynamic> json) {
    if (json['supplies_orders'] != null) {
      suppliesOrders = <SuppliesOrders>[];
      json['supplies_orders'].forEach((v) {
        suppliesOrders!.add(new SuppliesOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suppliesOrders != null) {
      data['supplies_orders'] =
          this.suppliesOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuppliesOrders {
  String? id;
  String? createdAt;
  String? updatedAt;
  Null? shortId;
  Null? supplyCouponId;
  dynamic? totalAmount;
  dynamic? taxAmount;
  double? deliveryCharge;
  dynamic? estimatedDeliveryInDays;
  String? status;
  String? paymentStatus;
  String? paymentMode;
  BillingAddress? billingAddress;
  BillingAddress? shippingAddress;
  Null? onlinePaymentOrderId;
  Null? onlinePaymentTransactionId;
  Null? onlinePaymentSignature;
  Null? approvedOn;
  Null? approvedMessage;
  Null? shippedOn;
  Null? shippedMessage;
  Null? deliveredOn;
  Null? deliveredMessage;
  Null? cancelledOn;
  Null? canceledMessage;
  Null? refundedOn;
  Null? refundedMessage;
  Null? customMessage;
  String? dentalPracticeId;
  DentalProfessional? dentalPractice;
  String? dentalProfessionalId;
  DentalProfessional? dentalProfessional;
  Null? dentalSupplierId;
  Null? dentalSupplier;
  Supplier? supplier;
  AccountPayDetails? accountPayDetails;
  String? suppliersId;
  double? couponDiscount;
  double? subTotal;
  int? orderNumber;
  List<SuppliesOrderNotes>? suppliesOrderNotes;
  String? sTypename;

  SuppliesOrders(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.shortId,
      this.supplyCouponId,
      this.totalAmount,
      this.taxAmount,
      this.deliveryCharge,
      this.estimatedDeliveryInDays,
      this.status,
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
      this.supplier,
      this.accountPayDetails,
      this.suppliersId,
      this.couponDiscount,
      this.subTotal,
      this.orderNumber,
      this.suppliesOrderNotes,
      this.sTypename});

  SuppliesOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shortId = json['short_id'];
    supplyCouponId = json['supply_coupon_id'];
    totalAmount = json['total_amount'];
    taxAmount = json['tax_amount'];
    deliveryCharge = json['delivery_charge'];
    estimatedDeliveryInDays = json['estimated_delivery_in_days'];
    status = json['status'];
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
        ? new DentalProfessional.fromJson(json['dental_practice'])
        : null;
    dentalProfessionalId = json['dental_professional_id'];
    dentalProfessional = json['dental_professional'] != null
        ? new DentalProfessional.fromJson(json['dental_professional'])
        : null;
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'];
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
    accountPayDetails = json['account_pay_details'] != null
        ? new AccountPayDetails.fromJson(json['account_pay_details'])
        : null;
    suppliersId = json['suppliers_id'];
    couponDiscount = json['coupon_discount'];
    subTotal = json['sub_total'];
    orderNumber = json['order_number'];
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
    data['delivery_charge'] = this.deliveryCharge;
    data['estimated_delivery_in_days'] = this.estimatedDeliveryInDays;
    data['status'] = this.status;
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
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    if (this.accountPayDetails != null) {
      data['account_pay_details'] = this.accountPayDetails!.toJson();
    }
    data['suppliers_id'] = this.suppliersId;
    data['coupon_discount'] = this.couponDiscount;
    data['sub_total'] = this.subTotal;
    data['order_number'] = this.orderNumber;
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
  String? email;
  String? sTypename;

  DentalProfessional(
      {this.id, this.name, this.phone, this.email, this.sTypename});

  DentalProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supplier {
  String? businessName;
  String? name;
  String? email;
  String? sTypename;

  Supplier({this.businessName, this.name, this.email, this.sTypename});

  Supplier.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    name = json['name'];
    email = json['email'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class AccountPayDetails {
  String? email;
  String? clinicName;
  String? companyName;
  String? paymentMode;
  String? accountNumber;

  AccountPayDetails(
      {this.email,
      this.clinicName,
      this.companyName,
      this.paymentMode,
      this.accountNumber});

  AccountPayDetails.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    clinicName = json['clinic_name'];
    companyName = json['company_name'];
    paymentMode = json['payment_mode'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['clinic_name'] = this.clinicName;
    data['company_name'] = this.companyName;
    data['payment_mode'] = this.paymentMode;
    data['account_number'] = this.accountNumber;
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
  String? sTypename;

  SuppliesOrderNotes(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.suppliesOrderId,
      this.status,
      this.message,
      this.sTypename});

  SuppliesOrderNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    suppliesOrderId = json['supplies_order_id'];
    status = json['status'];
    message = json['message'];
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
    data['__typename'] = this.sTypename;
    return data;
  }
}
