class SubscriptionPlanRes {
  SubscriptionData? data;

  SubscriptionPlanRes({this.data});

  SubscriptionPlanRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SubscriptionData.fromJson(json['data'])
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

class SubscriptionData {
  List<SubscriptionPlans>? subscriptionPlans;

  SubscriptionData({this.subscriptionPlans});

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    if (json['subscription_plans'] != null) {
      subscriptionPlans = <SubscriptionPlans>[];
      json['subscription_plans'].forEach((v) {
        subscriptionPlans!.add(new SubscriptionPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptionPlans != null) {
      data['subscription_plans'] =
          this.subscriptionPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionPlans {
  String? id;
  String? updatedAt;
  String? name;
  dynamic priceInAud;
  dynamic priceInUsd;
  dynamic tenureInDays;
  String? tenureType;
  String? termsAndConditions;
  String? type;
  String? description;
  List<Benefits>? benefits;
  String? planType;
  dynamic monthyPrice;
  dynamic yearlyPrice;
  String? planStatus;
  String? sTypename;

  SubscriptionPlans(
      {this.id,
      this.updatedAt,
      this.name,
      this.priceInAud,
      this.priceInUsd,
      this.tenureInDays,
      this.tenureType,
      this.termsAndConditions,
      this.type,
      this.description,
      this.benefits,
      this.planType,
      this.monthyPrice,
      this.yearlyPrice,
      this.planStatus,
      this.sTypename});

  SubscriptionPlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    name = json['name'];
    priceInAud = json['price_in_aud'];
    priceInUsd = json['price_in_usd'];
    tenureInDays = json['tenure_in_days'];
    tenureType = json['tenure_type'];
    termsAndConditions = json['terms_and_conditions'];
    type = json['type'];
    description = json['description'];
    if (json['benefits'] != null) {
      benefits = <Benefits>[];
      json['benefits'].forEach((v) {
        benefits!.add(new Benefits.fromJson(v));
      });
    }
    planType = json['plan_type'];
    monthyPrice = json['monthy_price'];
    yearlyPrice = json['yearly_price'];
    planStatus = json['plan_status'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['price_in_aud'] = this.priceInAud;
    data['price_in_usd'] = this.priceInUsd;
    data['tenure_in_days'] = this.tenureInDays;
    data['tenure_type'] = this.tenureType;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['type'] = this.type;
    data['description'] = this.description;
    if (this.benefits != null) {
      data['benefits'] = this.benefits!.map((v) => v.toJson()).toList();
    }
    data['plan_type'] = this.planType;
    data['monthy_price'] = this.monthyPrice;
    data['yearly_price'] = this.yearlyPrice;
    data['plan_status'] = this.planStatus;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Benefits {
  String? name;

  Benefits({this.name});

  Benefits.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
