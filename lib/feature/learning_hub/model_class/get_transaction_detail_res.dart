class GetTransactionDetailRes {
  String? id;
  String? courseId;
  int? coursePrice;
  String? dentalSupplierId;
  int? totalAmount;
  int? adminCommission;
  int? supplierAmount;
  int? discountAmount;
  String? currency;
  String? transactionStatus;
  String? stripePaymentIntentId;
  Null? promoCodeId;
  String? createdById;
  String? createdByType;
  String? createdAt;
  String? updatedAt;
  String? courseName;
  String? supplierName;
  String? buyerFirstName;
  String? buyerLastName;
  String? buyerEmail;
  String? buyerPhone;
  Null? refund;

  GetTransactionDetailRes(
      {this.id,
      this.courseId,
      this.coursePrice,
      this.dentalSupplierId,
      this.totalAmount,
      this.adminCommission,
      this.supplierAmount,
      this.discountAmount,
      this.currency,
      this.transactionStatus,
      this.stripePaymentIntentId,
      this.promoCodeId,
      this.createdById,
      this.createdByType,
      this.createdAt,
      this.updatedAt,
      this.courseName,
      this.supplierName,
      this.buyerFirstName,
      this.buyerLastName,
      this.buyerEmail,
      this.buyerPhone,
      this.refund});

  GetTransactionDetailRes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    coursePrice = json['course_price'];
    dentalSupplierId = json['dental_supplier_id'];
    totalAmount = json['total_amount'];
    adminCommission = json['admin_commission'];
    supplierAmount = json['supplier_amount'];
    discountAmount = json['discount_amount'];
    currency = json['currency'];
    transactionStatus = json['transaction_status'];
    stripePaymentIntentId = json['stripe_payment_intent_id'];
    promoCodeId = json['promo_code_id'];
    createdById = json['created_by_id'];
    createdByType = json['created_by_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseName = json['course_name'];
    supplierName = json['supplier_name'];
    buyerFirstName = json['buyer_first_name'];
    buyerLastName = json['buyer_last_name'];
    buyerEmail = json['buyer_email'];
    buyerPhone = json['buyer_phone'];
    refund = json['refund'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['course_price'] = this.coursePrice;
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['total_amount'] = this.totalAmount;
    data['admin_commission'] = this.adminCommission;
    data['supplier_amount'] = this.supplierAmount;
    data['discount_amount'] = this.discountAmount;
    data['currency'] = this.currency;
    data['transaction_status'] = this.transactionStatus;
    data['stripe_payment_intent_id'] = this.stripePaymentIntentId;
    data['promo_code_id'] = this.promoCodeId;
    data['created_by_id'] = this.createdById;
    data['created_by_type'] = this.createdByType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_name'] = this.courseName;
    data['supplier_name'] = this.supplierName;
    data['buyer_first_name'] = this.buyerFirstName;
    data['buyer_last_name'] = this.buyerLastName;
    data['buyer_email'] = this.buyerEmail;
    data['buyer_phone'] = this.buyerPhone;
    data['refund'] = this.refund;
    return data;
  }
}
