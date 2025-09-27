class EditBannerViewResp {
  BannerViewData? data;

  EditBannerViewResp({this.data});

  EditBannerViewResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new BannerViewData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BannerViewData {
  BannersByPk? bannersByPk;

  BannerViewData({this.bannersByPk});

  BannerViewData.fromJson(Map<String, dynamic> json) {
    bannersByPk = json['banners_by_pk'] != null
        ? new BannersByPk.fromJson(json['banners_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannersByPk != null) {
      data['banners_by_pk'] = this.bannersByPk!.toJson();
    }
    return data;
  }
}

class BannersByPk {
  String? status;
  String? expiryDate;
  List<Image>? image;
  String? scheduleDate;
  String? bannerName;
  String? url;
  String? categoryName;
  String? createdAt;
  String? updatedAt;
  String? fromId;
  String? id;
  String? sTypename;

  BannersByPk(
      {this.status,
      this.expiryDate,
      this.image,
      this.scheduleDate,
      this.bannerName,
      this.url,
      this.categoryName,
      this.createdAt,
      this.updatedAt,
      this.fromId,
      this.id,
      this.sTypename});

  BannersByPk.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    expiryDate = json['expiry_date'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    scheduleDate = json['schedule_date'];
    bannerName = json['banner_name'];
    url = json['url'];
    categoryName = json['category_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromId = json['from_id'];
    id = json['id'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['expiry_date'] = this.expiryDate;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['schedule_date'] = this.scheduleDate;
    data['banner_name'] = this.bannerName;
    data['url'] = this.url;
    data['category_name'] = this.categoryName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_id'] = this.fromId;
    data['id'] = this.id;
    data['__typename'] = this.sTypename;
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
