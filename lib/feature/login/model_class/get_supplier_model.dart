class GetSupplierRes {
  GetSupplierData? data;

  GetSupplierRes({this.data});

  GetSupplierRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetSupplierData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetSupplierData {
  DentalSuppliersByPk? dentalSuppliersByPk;

  GetSupplierData({this.dentalSuppliersByPk});

  GetSupplierData.fromJson(Map<String, dynamic> json) {
    dentalSuppliersByPk = json['dental_suppliers_by_pk'] != null
        ? new DentalSuppliersByPk.fromJson(json['dental_suppliers_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalSuppliersByPk != null) {
      data['dental_suppliers_by_pk'] = this.dentalSuppliersByPk!.toJson();
    }
    return data;
  }
}

class DentalSuppliersByPk {
  String? id;
  bool? secondHand;
  bool? sellProducts;
  bool? profileCompleted;
  String? stripeCustomerId;
  List<Directories>? directories;
  String? presentSubscriptionId;
  List<UserSubscription>? userSubscriptions;
  String? sTypename;

  DentalSuppliersByPk(
      {this.id,
      this.secondHand,
      this.sellProducts,
      this.profileCompleted,
      this.stripeCustomerId,
      this.directories,
      this.presentSubscriptionId,
      this.userSubscriptions,
      this.sTypename});

  DentalSuppliersByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    secondHand = json['second_hand'];
    sellProducts = json['sell_products'];
    profileCompleted = json['profile_completed'];
    stripeCustomerId = json['stripe_customer_id'];
    if (json['directories'] != null) {
      directories = <Directories>[];
      json['directories'].forEach((v) {
        directories!.add(new Directories.fromJson(v));
      });
    }
    presentSubscriptionId = json['present_subscription_id'];
    if (json['user_subscriptions'] != null) {
      userSubscriptions = <UserSubscription>[];
      json['user_subscriptions'].forEach((v) {
        userSubscriptions!.add(new UserSubscription.fromJson(v));
      });
    }
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['second_hand'] = this.secondHand;
    data['sell_products'] = this.sellProducts;
    data['profile_completed'] = this.profileCompleted;
    data['stripe_customer_id'] = this.stripeCustomerId;
    if (this.directories != null) {
      data['directories'] = this.directories!.map((v) => v.toJson()).toList();
    }
    data['present_subscription_id'] = this.presentSubscriptionId;
    if (this.userSubscriptions != null) {
      data['user_subscriptions'] =
          this.userSubscriptions!.map((v) => v.toJson()).toList();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class UserSubscription {
  String? id;
  String? sTypename;

  UserSubscription({this.id, this.sTypename});

  UserSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Directories {
  String? directoryCategoryId;
  String? sTypename;

  Directories({this.directoryCategoryId, this.sTypename});

  Directories.fromJson(Map<String, dynamic> json) {
    directoryCategoryId = json['directory_category_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['directory_category_id'] = this.directoryCategoryId;
    data['__typename'] = this.sTypename;
    return data;
  }
}
