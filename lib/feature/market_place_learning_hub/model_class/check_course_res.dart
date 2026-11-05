class CheckCourseRes {
  String? courseId;
  int? price;
  bool? isFree;
  bool? isExpired;
  Null? registeredCourseId;
  Null? autoAppliedPromo;
  bool? requiresManualPromoInput;
  Null? resumablePayment;

  CheckCourseRes(
      {this.courseId,
      this.price,
      this.isFree,
      this.isExpired,
      this.registeredCourseId,
      this.autoAppliedPromo,
      this.requiresManualPromoInput,
      this.resumablePayment});

  CheckCourseRes.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    price = json['price'];
    isFree = json['isFree'];
    isExpired = json['isExpired'];
    registeredCourseId = json['registeredCourseId'];
    autoAppliedPromo = json['autoAppliedPromo'];
    requiresManualPromoInput = json['requiresManualPromoInput'];
    resumablePayment = json['resumablePayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    data['price'] = this.price;
    data['isFree'] = this.isFree;
    data['isExpired'] = this.isExpired;
    data['registeredCourseId'] = this.registeredCourseId;
    data['autoAppliedPromo'] = this.autoAppliedPromo;
    data['requiresManualPromoInput'] = this.requiresManualPromoInput;
    data['resumablePayment'] = this.resumablePayment;
    return data;
  }
}
