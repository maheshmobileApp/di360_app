class getBannerCategoryResp {
  BannersCategoriesData? data;

  getBannerCategoryResp({this.data});

  getBannerCategoryResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new BannersCategoriesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BannersCategoriesData {
  List<BannerCategories>? bannerCategories;

  BannersCategoriesData({this.bannerCategories});

  BannersCategoriesData.fromJson(Map<String, dynamic> json) {
    if (json['banner_categories'] != null) {
      bannerCategories = <BannerCategories>[];
      json['banner_categories'].forEach((v) {
        bannerCategories!.add(new BannerCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerCategories != null) {
      data['banner_categories'] =
          this.bannerCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerCategories {
  String? id;
  String? name;
  String? dimensions;
  List<String>? bannerLocation;
  int? timer;
  String? createdAt;
  String? updatedAt;
  String? status;

  BannerCategories(
      {this.id,
      this.name,
      this.dimensions,
      this.bannerLocation,
      this.timer,
      this.createdAt,
      this.updatedAt,
      this.status});

  BannerCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dimensions = json['dimensions'];
    bannerLocation = json['banner_location'].cast<String>();
    timer = json['timer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dimensions'] = this.dimensions;
    data['banner_location'] = this.bannerLocation;
    data['timer'] = this.timer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
