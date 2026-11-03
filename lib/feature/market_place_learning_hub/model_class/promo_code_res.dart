class PromoCodeRes {
  String? promoId;
  String? promoCode;
  int? originalPrice;
  int? discountAmount;
  int? finalPrice;

  PromoCodeRes(
      {this.promoId,
      this.promoCode,
      this.originalPrice,
      this.discountAmount,
      this.finalPrice});

  PromoCodeRes.fromJson(Map<String, dynamic> json) {
    promoId = json['promoId'];
    promoCode = json['promoCode'];
    originalPrice = json['originalPrice'];
    discountAmount = json['discountAmount'];
    finalPrice = json['finalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promoId'] = this.promoId;
    data['promoCode'] = this.promoCode;
    data['originalPrice'] = this.originalPrice;
    data['discountAmount'] = this.discountAmount;
    data['finalPrice'] = this.finalPrice;
    return data;
  }
}
