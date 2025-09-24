class DeleteBannerResp {
  DeleteBannerData? data;

  DeleteBannerResp({this.data});

  DeleteBannerResp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DeleteBannerData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DeleteBannerData {
  DeleteBannersByPk? deleteBannersByPk;

  DeleteBannerData({this.deleteBannersByPk});

  DeleteBannerData.fromJson(Map<String, dynamic> json) {
    deleteBannersByPk = json['delete_banners_by_pk'] != null
        ? new DeleteBannersByPk.fromJson(json['delete_banners_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deleteBannersByPk != null) {
      data['delete_banners_by_pk'] = this.deleteBannersByPk!.toJson();
    }
    return data;
  }
}

class DeleteBannersByPk {
  String? id;
  String? sTypename;

  DeleteBannersByPk({this.id, this.sTypename});

  DeleteBannersByPk.fromJson(Map<String, dynamic> json) {
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
