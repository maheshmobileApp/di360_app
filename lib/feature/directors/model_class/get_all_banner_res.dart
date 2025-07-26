class GetAllBannersRes {
  BannersData? data;

  GetAllBannersRes({this.data});

  GetAllBannersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new BannersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BannersData {
  List<Banners>? banners;

  BannersData({this.banners});

  BannersData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? id;
  String? bannerName;
  String? categoryName;
  String? status;
  String? expiryDate;
  List<Images>? image;
  String? scheduleDate;
  String? createdAt;
  String? updatedAt;
  String? fromId;
  int? views;
  String? url;
  String? companyName;
  DentalSuppliers? dentalSuppliers;
  BannerCategories? bannerCategories;
  String? sTypename;

  Banners(
      {this.id,
      this.bannerName,
      this.categoryName,
      this.status,
      this.expiryDate,
      this.image,
      this.scheduleDate,
      this.createdAt,
      this.updatedAt,
      this.fromId,
      this.views,
      this.url,
      this.companyName,
      this.dentalSuppliers,
      this.bannerCategories,
      this.sTypename});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerName = json['banner_name'];
    categoryName = json['category_name'];
    status = json['status'];
    expiryDate = json['expiry_date'];
    if (json['image'] != null) {
      if (json['image'] is List) {
        image = (json['image'] as List)
            .map((item) => Images.fromJson(item))
            .toList();
      } else if (json['image'] is Map) {
        image = [Images.fromJson(json['image'])];
      }
    }
    scheduleDate = json['schedule_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromId = json['from_id'];
    views = json['views'];
    url = json['url'];
    companyName = json['company_name'];
    dentalSuppliers = json['dental_suppliers'] != null
        ? new DentalSuppliers.fromJson(json['dental_suppliers'])
        : null;
    bannerCategories = json['banner_categories'] != null
        ? new BannerCategories.fromJson(json['banner_categories'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_name'] = this.bannerName;
    data['category_name'] = this.categoryName;
    data['status'] = this.status;
    data['expiry_date'] = this.expiryDate;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['schedule_date'] = this.scheduleDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_id'] = this.fromId;
    data['views'] = this.views;
    data['url'] = this.url;
    data['company_name'] = this.companyName;
    if (this.dentalSuppliers != null) {
      data['dental_suppliers'] = this.dentalSuppliers!.toJson();
    }
    if (this.bannerCategories != null) {
      data['banner_categories'] = this.bannerCategories!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Images {
  String? url;
  String? name;
  String? type;
  String? extension;

  Images({this.url, this.name, this.type, this.extension});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    type = json['type'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['extension'] = this.extension;
    return data;
  }
}

class DentalSuppliers {
  String? name;
  String? sTypename;

  DentalSuppliers({this.name, this.sTypename});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}

class BannerCategories {
  String? id;
  String? name;
  List<String>? bannerLocation;
  int? timer;
  String? sTypename;

  BannerCategories(
      {this.id, this.name, this.bannerLocation, this.timer, this.sTypename});

  BannerCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bannerLocation = json['banner_location'].cast<String>();
    timer = json['timer'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['banner_location'] = this.bannerLocation;
    data['timer'] = this.timer;
    data['__typename'] = this.sTypename;
    return data;
  }
}
