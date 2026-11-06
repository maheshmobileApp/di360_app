class GetTransactionsRes {
  List<TransactionData>? data;
  int? totalCount;

  GetTransactionsRes({this.data, this.totalCount});

  GetTransactionsRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(new TransactionData.fromJson(v));
      });
    }
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
    return data;
  }
}

class TransactionData {
  String? id;
  String? courseId;
  String? dentalSupplierId;
  String? courseOwnerId;
  dynamic? totalAmount;
  dynamic? adminCommission;
  dynamic? supplierAmount;
  dynamic? discountAmount;
  String? currency;
  String? transactionStatus;
  String? stripePaymentIntentId;
  String? createdById;
  String? createdByType;
  String? createdAt;
  Courses? courses;
  String? courseName;
  String? buyerName;
  String? buyerEmail;

  TransactionData(
      {this.id,
      this.courseId,
      this.dentalSupplierId,
      this.courseOwnerId,
      this.totalAmount,
      this.adminCommission,
      this.supplierAmount,
      this.discountAmount,
      this.currency,
      this.transactionStatus,
      this.stripePaymentIntentId,
      this.createdById,
      this.createdByType,
      this.createdAt,
      this.courses,
      this.courseName,
      this.buyerName,
      this.buyerEmail});

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    dentalSupplierId = json['dental_supplier_id'];
    courseOwnerId = json['course_owner_id'];
    totalAmount = json['total_amount'];
    adminCommission = json['admin_commission'];
    supplierAmount = json['supplier_amount'];
    discountAmount = json['discount_amount'];
    currency = json['currency'];
    transactionStatus = json['transaction_status'];
    stripePaymentIntentId = json['stripe_payment_intent_id'];
    createdById = json['created_by_id'];
    createdByType = json['created_by_type'];
    createdAt = json['created_at'];
    courses =
        json['courses'] != null ? new Courses.fromJson(json['courses']) : null;
    courseName = json['course_name'];
    buyerName = json['buyer_name'];
    buyerEmail = json['buyer_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['course_owner_id'] = this.courseOwnerId;
    data['total_amount'] = this.totalAmount;
    data['admin_commission'] = this.adminCommission;
    data['supplier_amount'] = this.supplierAmount;
    data['discount_amount'] = this.discountAmount;
    data['currency'] = this.currency;
    data['transaction_status'] = this.transactionStatus;
    data['stripe_payment_intent_id'] = this.stripePaymentIntentId;
    data['created_by_id'] = this.createdById;
    data['created_by_type'] = this.createdByType;
    data['created_at'] = this.createdAt;
    if (this.courses != null) {
      data['courses'] = this.courses!.toJson();
    }
    data['course_name'] = this.courseName;
    data['buyer_name'] = this.buyerName;
    data['buyer_email'] = this.buyerEmail;
    return data;
  }
}

class Courses {
  String? courseName;

  Courses({this.courseName});

  Courses.fromJson(Map<String, dynamic> json) {
    courseName = json['course_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_name'] = this.courseName;
    return data;
  }
}
