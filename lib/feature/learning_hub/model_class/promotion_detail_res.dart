class PromotionDetailRes {
  PromotionDetailData? data;

  PromotionDetailRes({this.data});

  PromotionDetailRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PromotionDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PromotionDetailData {
  CoursePromotionsByPk? coursePromotionsByPk;

  PromotionDetailData({this.coursePromotionsByPk});

  PromotionDetailData.fromJson(Map<String, dynamic> json) {
    coursePromotionsByPk = json['course_promotions_by_pk'] != null
        ? new CoursePromotionsByPk.fromJson(json['course_promotions_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coursePromotionsByPk != null) {
      data['course_promotions_by_pk'] = this.coursePromotionsByPk!.toJson();
    }
    return data;
  }
}

class CoursePromotionsByPk {
  String? id;
  String? courseId;
  String? promotionName;
  String? promoCode;
  String? discountType;
  dynamic? discountValue;
  dynamic? maxDiscountAmount;
  String? eligibleUserType;
  dynamic? usageLimit;
  dynamic? usedCount;
  String? validFrom;
  String? validUntil;
  bool? autoApply;
  String? status;
  String? createdById;
  String? createdByRole;
  String? createdAt;
  String? updatedAt;
  String? sTypename;

  CoursePromotionsByPk(
      {this.id,
      this.courseId,
      this.promotionName,
      this.promoCode,
      this.discountType,
      this.discountValue,
      this.maxDiscountAmount,
      this.eligibleUserType,
      this.usageLimit,
      this.usedCount,
      this.validFrom,
      this.validUntil,
      this.autoApply,
      this.status,
      this.createdById,
      this.createdByRole,
      this.createdAt,
      this.updatedAt,
      this.sTypename});

  CoursePromotionsByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    promotionName = json['promotion_name'];
    promoCode = json['promo_code'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    maxDiscountAmount = json['max_discount_amount'];
    eligibleUserType = json['eligible_user_type'];
    usageLimit = json['usage_limit'];
    usedCount = json['used_count'];
    validFrom = json['valid_from'];
    validUntil = json['valid_until'];
    autoApply = json['auto_apply'];
    status = json['status'];
    createdById = json['created_by_id'];
    createdByRole = json['created_by_role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['promotion_name'] = this.promotionName;
    data['promo_code'] = this.promoCode;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['max_discount_amount'] = this.maxDiscountAmount;
    data['eligible_user_type'] = this.eligibleUserType;
    data['usage_limit'] = this.usageLimit;
    data['used_count'] = this.usedCount;
    data['valid_from'] = this.validFrom;
    data['valid_until'] = this.validUntil;
    data['auto_apply'] = this.autoApply;
    data['status'] = this.status;
    data['created_by_id'] = this.createdById;
    data['created_by_role'] = this.createdByRole;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__typename'] = this.sTypename;
    return data;
  }
}
