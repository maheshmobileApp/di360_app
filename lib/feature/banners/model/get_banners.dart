 
 class getBannerResp {
  BannersData? data;

  getBannerResp({this.data});

  getBannerResp.fromJson(Map<String, dynamic> json) {
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
  BannersAggregate? bannersAggregate;

  BannersData({this.banners, this.bannersAggregate});

  BannersData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    bannersAggregate = json['banners_aggregate'] != null
        ? new BannersAggregate.fromJson(json['banners_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.bannersAggregate != null) {
      data['banners_aggregate'] = this.bannersAggregate!.toJson();
    }
    return data;
  }
}

class Banners {
  String? status;
  String? expiryDate;
  List<Image>? image;
  String? scheduleDate;
  String? bannerName;
  String? categoryName;
  String? companyName;
  String? createdAt;
  String? updatedAt;
  String? fromId;
  String? id;
  int? views;
  DentalSuppliers? dentalSuppliers;

  Banners(
      {this.status,
      this.expiryDate,
      this.image,
      this.scheduleDate,
      this.bannerName,
      this.categoryName,
      this.companyName,
      this.createdAt,
      this.updatedAt,
      this.fromId,
      this.id,
      this.views,
      this.dentalSuppliers});

  Banners.fromJson(Map<String, dynamic> json) {
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
    categoryName = json['category_name'];
    companyName = json['company_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromId = json['from_id'];
    id = json['id'];
    views = json['views'];
    dentalSuppliers = json['dental_suppliers'] != null
        ? new DentalSuppliers.fromJson(json['dental_suppliers'])
        : null;
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
    data['category_name'] = this.categoryName;
    data['company_name'] = this.companyName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_id'] = this.fromId;
    data['id'] = this.id;
    data['views'] = this.views;
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
  String? id;
  String? name;
  String? type;

  DentalSuppliers({this.id, this.name, this.type});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class BannersAggregate {
  Aggregate? aggregate;

  BannersAggregate({this.aggregate});

  BannersAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class Aggregate {
  int? count;

  Aggregate({this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
