class GetBannerRes {
  GetBannerData? data;

  GetBannerRes({this.data});

  GetBannerRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetBannerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetBannerData {
  List<Banners>? banners;

  GetBannerData({this.banners});

  GetBannerData.fromJson(Map<String, dynamic> json) {
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
  List<Image>? image;
  String? url;
  BannerCategories? bannerCategories;
  String? sTypename;

  Banners(
      {this.id, this.image, this.url, this.bannerCategories, this.sTypename});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    url = json['url'];
    bannerCategories = json['banner_categories'] != null
        ? new BannerCategories.fromJson(json['banner_categories'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['url'] = this.url;
    if (this.bannerCategories != null) {
      data['banner_categories'] = this.bannerCategories!.toJson();
    }
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

class BannerCategories {
  int? timer;
  String? sTypename;

  BannerCategories({this.timer, this.sTypename});

  BannerCategories.fromJson(Map<String, dynamic> json) {
    timer = json['timer'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timer'] = this.timer;
    data['__typename'] = this.sTypename;
    return data;
  }
}
