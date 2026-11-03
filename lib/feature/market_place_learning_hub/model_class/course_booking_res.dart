class CourseBookingRes {
  bool? registered;
  bool? requiresPayment;
  Transaction? transaction;
  String? clientSecret;

  CourseBookingRes(
      {this.registered,
      this.requiresPayment,
      this.transaction,
      this.clientSecret});

  CourseBookingRes.fromJson(Map<String, dynamic> json) {
    registered = json['registered'];
    requiresPayment = json['requiresPayment'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    clientSecret = json['clientSecret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registered'] = this.registered;
    data['requiresPayment'] = this.requiresPayment;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    data['clientSecret'] = this.clientSecret;
    return data;
  }
}

class Transaction {
  String? id;
  int? totalAmount;
  dynamic? adminCommission;
  dynamic? supplierAmount;
  String? transactionStatus;
  String? stripePaymentIntentId;
  int? coursePrice;
  int? coursePlatformCommissionPercentage;

  Transaction(
      {this.id,
      this.totalAmount,
      this.adminCommission,
      this.supplierAmount,
      this.transactionStatus,
      this.stripePaymentIntentId,
      this.coursePrice,
      this.coursePlatformCommissionPercentage});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    adminCommission = json['admin_commission'];
    supplierAmount = json['supplier_amount'];
    transactionStatus = json['transaction_status'];
    stripePaymentIntentId = json['stripe_payment_intent_id'];
    coursePrice = json['course_price'];
    coursePlatformCommissionPercentage =
        json['course_platform_commission_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_amount'] = this.totalAmount;
    data['admin_commission'] = this.adminCommission;
    data['supplier_amount'] = this.supplierAmount;
    data['transaction_status'] = this.transactionStatus;
    data['stripe_payment_intent_id'] = this.stripePaymentIntentId;
    data['course_price'] = this.coursePrice;
    data['course_platform_commission_percentage'] =
        this.coursePlatformCommissionPercentage;
    return data;
  }
}
