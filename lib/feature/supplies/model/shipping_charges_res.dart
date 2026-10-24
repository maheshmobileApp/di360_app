class ShippingChargesRes {
  ShippingChargesData? data;

  ShippingChargesRes({this.data});

  ShippingChargesRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ShippingChargesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ShippingChargesData {
  List<FreightRanges>? freightRanges;

  ShippingChargesData({this.freightRanges});

  ShippingChargesData.fromJson(Map<String, dynamic> json) {
    if (json['freight_ranges'] != null) {
      freightRanges = <FreightRanges>[];
      json['freight_ranges'].forEach((v) {
        freightRanges!.add(new FreightRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.freightRanges != null) {
      data['freight_ranges'] =
          this.freightRanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FreightRanges {
  String? id;
  String? shippingRule;
  dynamic? shippingCost;
  int? minOrderValue;
  int? minNoProducts;
  String? stdEstDelivery;
  bool? expressPostEnabled;
  int? expressPostCost;
  String? expressDeliveryEta;
  bool? isActive;
  String? sTypename;

  FreightRanges(
      {this.id,
      this.shippingRule,
      this.shippingCost,
      this.minOrderValue,
      this.minNoProducts,
      this.stdEstDelivery,
      this.expressPostEnabled,
      this.expressPostCost,
      this.expressDeliveryEta,
      this.isActive,
      this.sTypename});

  FreightRanges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingRule = json['shipping_rule'];
    shippingCost = json['shipping_cost'];
    minOrderValue = json['min_order_value'];
    minNoProducts = json['min_no_products'];
    stdEstDelivery = json['std_est_delivery'];
    expressPostEnabled = json['express_post_enabled'];
    expressPostCost = json['express_post_cost'];
    expressDeliveryEta = json['express_delivery_eta'];
    isActive = json['is_active'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shipping_rule'] = this.shippingRule;
    data['shipping_cost'] = this.shippingCost;
    data['min_order_value'] = this.minOrderValue;
    data['min_no_products'] = this.minNoProducts;
    data['std_est_delivery'] = this.stdEstDelivery;
    data['express_post_enabled'] = this.expressPostEnabled;
    data['express_post_cost'] = this.expressPostCost;
    data['express_delivery_eta'] = this.expressDeliveryEta;
    data['is_active'] = this.isActive;
    data['__typename'] = this.sTypename;
    return data;
  }
}
