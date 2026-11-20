class PromoCodeRes {
  String? promoId;
  String? promoCode;
  int? originalPrice;
  int? discountAmount;
  int? finalPrice;
  int? statusCode;
  String? message;

  PromoCodeRes(
      {this.promoId,
      this.promoCode,
      this.originalPrice,
      this.discountAmount,
      this.finalPrice,
      this.statusCode,
      this.message,});

  PromoCodeRes.fromJson(Map<String, dynamic> json) {
    promoId = json['promoId'];
    promoCode = json['promoCode'];
    originalPrice = json['originalPrice'];
    discountAmount = json['discountAmount'];
    finalPrice = json['finalPrice'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promoId'] = this.promoId;
    data['promoCode'] = this.promoCode;
    data['originalPrice'] = this.originalPrice;
    data['discountAmount'] = this.discountAmount;
    data['finalPrice'] = this.finalPrice;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}
