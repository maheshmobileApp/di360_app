class LogInRes {
  LogInData? data;

  LogInRes({this.data});

  LogInRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LogInData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LogInData {
  LoginApi? loginApi;

  LogInData({this.loginApi});

  LogInData.fromJson(Map<String, dynamic> json) {
    loginApi = json['login_api'] != null
        ? new LoginApi.fromJson(json['login_api'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loginApi != null) {
      data['login_api'] = this.loginApi!.toJson();
    }
    return data;
  }
}

class LoginApi {
  String? id;
  String? accessToken;
  String? refreshToken;
  String? name;
  String? email;
  String? phone;
  Logo? logo;
  String? status;
  dynamic message;
  bool? profileCompleted;
  ProfileImage? profileImage;
  String? type;
  dynamic address;
  dynamic directoryCategoryId;
  dynamic professionType;
  bool? secondHand;
  String? businessName;
  dynamic abnNumber;
  String? gender;
  bool? sellProducts;
  dynamic dashboardPermissions;
  String? planId;
  String? paymentStatus;
  String? subscriptionId;
  SubscriptionPermissions? subscriptionPermissions;
  String? subType;
  String? ownerId;
  String? sTypename;

  LoginApi(
      {this.id,
      this.accessToken,
      this.refreshToken,
      this.name,
      this.email,
      this.phone,
      this.logo,
      this.status,
      this.message,
      this.profileCompleted,
      this.profileImage,
      this.type,
      this.address,
      this.directoryCategoryId,
      this.professionType,
      this.secondHand,
      this.businessName,
      this.abnNumber,
      this.gender,
      this.sellProducts,
      this.dashboardPermissions,
      this.planId,
      this.paymentStatus,
      this.subscriptionId,
      this.subscriptionPermissions,
      this.subType,
      this.ownerId,
      this.sTypename});

  LoginApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    status = json['status'];
    message = json['message'];
    profileCompleted = json['profile_completed'];
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    type = json['type'];
    address = json['address'];
    directoryCategoryId = json['directory_category_id'];
    professionType = json['profession_type'];
    secondHand = json['second_hand'];
    businessName = json['business_name'];
    abnNumber = json['abn_number'];
    gender = json['gender'];
    sellProducts = json['sell_products'];
    dashboardPermissions = json['dashboard_permissions'];
    planId = json['plan_id'];
    paymentStatus = json['payment_status'];
    subscriptionId = json['subscription_id'];
   subscriptionPermissions = json['subscription_permissions'] != null
        ? new SubscriptionPermissions.fromJson(json['subscription_permissions'])
        : null;
    subType = json['sub_type'];
    ownerId = json['owner_id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['profile_completed'] = this.profileCompleted;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['type'] = this.type;
    data['address'] = this.address;
    data['directory_category_id'] = this.directoryCategoryId;
    data['profession_type'] = this.professionType;
    data['second_hand'] = this.secondHand;
    data['business_name'] = this.businessName;
    data['abn_number'] = this.abnNumber;
    data['gender'] = this.gender;
    data['sell_products'] = this.sellProducts;
    data['dashboard_permissions'] = this.dashboardPermissions;
    data['plan_id'] = this.planId;
    data['payment_status'] = this.paymentStatus;
    data['subscription_id'] = this.subscriptionId;
    if (this.subscriptionPermissions != null) {
      data['subscription_permissions'] = this.subscriptionPermissions!.toJson();
    }
    data['sub_type'] = this.subType;
    data['owner_id'] = this.ownerId;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class SubscriptionPermissions {
  List<Marketplace>? marketplace;
  List<Modules>? modules;

  SubscriptionPermissions({this.marketplace, this.modules});

  SubscriptionPermissions.fromJson(Map<String, dynamic> json) {
    if (json['marketplace'] != null) {
      marketplace = <Marketplace>[];
      json['marketplace'].forEach((v) {
        marketplace!.add(Marketplace.fromJson(v));
      });
    }
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (marketplace != null) {
      data['marketplace'] = marketplace!.map((v) => v.toJson()).toList();
    }
    if (modules != null) {
      data['modules'] = modules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Marketplace {
  bool? myDashboard;
  bool? jobseek;
  bool? listJobs;
  bool? talentSearchPermission;
  bool? cataloguesPermission;
  bool? directoryPermission;
  bool? learningHubPermission;
  bool? secondHandSupplies;
  bool? suppliesPermission;
  bool? buySellPermission;

  Marketplace(
      {this.myDashboard,
      this.jobseek,
      this.listJobs,
      this.talentSearchPermission,
      this.cataloguesPermission,
      this.directoryPermission,
      this.learningHubPermission,
      this.secondHandSupplies,
      this.suppliesPermission,
      this.buySellPermission});

  Marketplace.fromJson(Map<String, dynamic> json) {
    myDashboard = json['my_dashboard'];
    jobseek = json['jobseek'];
    listJobs = json['list_jobs'];
    talentSearchPermission = json['talent_search_permission'];
    cataloguesPermission = json['catalogues_permission'];
    directoryPermission = json['directory_permission'];
    learningHubPermission = json['learning_hub_permission'];
    secondHandSupplies = json['second_hand_supplies'];
    suppliesPermission = json['supplies_permission'];
    buySellPermission = json['buy_sell_permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['my_dashboard'] = myDashboard;
    data['jobseek'] = jobseek;
    data['list_jobs'] = listJobs;
    data['talent_search_permission'] = talentSearchPermission;
    data['catalogues_permission'] = cataloguesPermission;
    data['directory_permission'] = directoryPermission;
    data['learning_hub_permission'] = learningHubPermission;
    data['second_hand_supplies'] = secondHandSupplies;
    data['supplies_permission'] = suppliesPermission;
    data['buy_sell_permission'] = buySellPermission;
    return data;
  }
}

class Modules {
  int? count;
  String? name;
  bool? permission;

  Modules({this.count, this.name, this.permission});

  Modules.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['name'] = name;
    data['permission'] = permission;
    return data;
  }
}

class Logo {
  String? directory;
  String? extension;
  String? fileId;
  bool? isPublic;
  String? mimeType;
  String? name;
  int? size;
  String? status;
  String? url;

  Logo(
      {this.directory,
      this.extension,
      this.fileId,
      this.isPublic,
      this.mimeType,
      this.name,
      this.size,
      this.status,
      this.url});

  Logo.fromJson(Map<String, dynamic> json) {
    directory = json['directory'];
    extension = json['extension'];
    fileId = json['file_id'];
    isPublic = json['isPublic'];
    mimeType = json['mime_type'];
    name = json['name'];
    size = json['size'];
    status = json['status'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['directory'] = this.directory;
    data['extension'] = this.extension;
    data['file_id'] = this.fileId;
    data['isPublic'] = this.isPublic;
    data['mime_type'] = this.mimeType;
    data['name'] = this.name;
    data['size'] = this.size;
    data['status'] = this.status;
    data['url'] = this.url;
    return data;
  }
}

class ProfileImage {
  String? directory;
  String? extension;
  String? fileId;
  bool? isPublic;
  String? mimeType;
  String? name;
  int? size;
  String? status;
  String? url;

  ProfileImage(
      {this.directory,
      this.extension,
      this.fileId,
      this.isPublic,
      this.mimeType,
      this.name,
      this.size,
      this.status,
      this.url});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    directory = json['directory'];
    extension = json['extension'];
    fileId = json['file_id'];
    isPublic = json['isPublic'];
    mimeType = json['mime_type'];
    name = json['name'];
    size = json['size'];
    status = json['status'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['directory'] = this.directory;
    data['extension'] = this.extension;
    data['file_id'] = this.fileId;
    data['isPublic'] = this.isPublic;
    data['mime_type'] = this.mimeType;
    data['name'] = this.name;
    data['size'] = this.size;
    data['status'] = this.status;
    data['url'] = this.url;
    return data;
  }
}
