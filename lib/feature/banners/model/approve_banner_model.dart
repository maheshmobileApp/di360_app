class ApproveBannerResp {
  ApproveBannerData? data;

  ApproveBannerResp({this.data});

  ApproveBannerResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ApproveBannerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ApproveBannerData {
  List<ApproveBanners>? banners;

  ApproveBannerData({this.banners});

  ApproveBannerData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <ApproveBanners>[];
      json['banners'].forEach((v) {
        banners!.add(new ApproveBanners.fromJson(v));
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

class ApproveBanners {
  String? id;
  String? bannerName;
  String? categoryName;
  String? status;
  int? views;
  String? expiryDate;
  List<Image>? image;
  String? scheduleDate;
  String? createdAt;
  String? updatedAt;
  String? fromId;
  String? url;
  String? companyName;
  DentalSuppliers? dentalSuppliers;

  ApproveBanners(
      {this.id,
      this.bannerName,
      this.categoryName,
      this.status,
      this.views,
      this.expiryDate,
      this.image,
      this.scheduleDate,
      this.createdAt,
      this.updatedAt,
      this.fromId,
      this.url,
      this.companyName,
      this.dentalSuppliers});

  ApproveBanners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerName = json['banner_name'];
    categoryName = json['category_name'];
    status = json['status'];
    views = json['views'];
    expiryDate = json['expiry_date'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    scheduleDate = json['schedule_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromId = json['from_id'];
    url = json['url'];
    companyName = json['company_name'];
    dentalSuppliers = json['dental_suppliers'] != null
        ? new DentalSuppliers.fromJson(json['dental_suppliers'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_name'] = this.bannerName;
    data['category_name'] = this.categoryName;
    data['status'] = this.status;
    data['views'] = this.views;
    data['expiry_date'] = this.expiryDate;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['schedule_date'] = this.scheduleDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_id'] = this.fromId;
    data['url'] = this.url;
    data['company_name'] = this.companyName;
    if (this.dentalSuppliers != null) {
      data['dental_suppliers'] = this.dentalSuppliers!.toJson();
    }
    return data;
  }
}

class Image {
  String? url;
  String? name;
  String? type;
  String? extension;

  Image({this.url, this.name, this.type, this.extension});

  Image.fromJson(Map<String, dynamic> json) {
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

  DentalSuppliers({this.name});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
