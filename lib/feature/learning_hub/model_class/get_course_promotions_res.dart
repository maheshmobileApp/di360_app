class GetCoursePromotionsRes {
  CoursePromotionData? data;

  GetCoursePromotionsRes({this.data});

  GetCoursePromotionsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CoursePromotionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CoursePromotionData {
  List<CoursePromotions>? coursePromotions;
  CoursePromotionsAggregate? coursePromotionsAggregate;

  CoursePromotionData({this.coursePromotions, this.coursePromotionsAggregate});

  CoursePromotionData.fromJson(Map<String, dynamic> json) {
    if (json['course_promotions'] != null) {
      coursePromotions = <CoursePromotions>[];
      json['course_promotions'].forEach((v) {
        coursePromotions!.add(new CoursePromotions.fromJson(v));
      });
    }
    coursePromotionsAggregate = json['course_promotions_aggregate'] != null
        ? new CoursePromotionsAggregate.fromJson(
            json['course_promotions_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coursePromotions != null) {
      data['course_promotions'] =
          this.coursePromotions!.map((v) => v.toJson()).toList();
    }
    if (this.coursePromotionsAggregate != null) {
      data['course_promotions_aggregate'] =
          this.coursePromotionsAggregate!.toJson();
    }
    return data;
  }
}

class CoursePromotions {
  String? id;
  String? courseId;
  String? promotionName;
  String? promoCode;
  String? discountType;
  dynamic? discountValue;
  dynamic? maxDiscountAmount;
  String? eligibleUserType;
  Null? usageLimit;
  dynamic? usedCount;
  String? validFrom;
  String? validUntil;
  bool? autoApply;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? sTypename;

  CoursePromotions(
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
      this.createdAt,
      this.updatedAt,
      this.sTypename});

  CoursePromotions.fromJson(Map<String, dynamic> json) {
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class CoursePromotionsAggregate {
  Aggregate? aggregate;
  String? sTypename;

  CoursePromotionsAggregate({this.aggregate, this.sTypename});

  CoursePromotionsAggregate.fromJson(Map<String, dynamic> json) {
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
