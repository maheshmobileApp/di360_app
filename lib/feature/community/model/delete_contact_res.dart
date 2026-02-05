class DeleteContactRes {
  DeleteContactData? data;

  DeleteContactRes({this.data});

  DeleteContactRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DeleteContactData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DeleteContactData {
  DeletePartnersContactBookByPk? deletePartnersContactBookByPk;

  DeleteContactData({this.deletePartnersContactBookByPk});

  DeleteContactData.fromJson(Map<String, dynamic> json) {
    deletePartnersContactBookByPk =
        json['delete_partners_contact_book_by_pk'] != null
            ? new DeletePartnersContactBookByPk.fromJson(
                json['delete_partners_contact_book_by_pk'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deletePartnersContactBookByPk != null) {
      data['delete_partners_contact_book_by_pk'] =
          this.deletePartnersContactBookByPk!.toJson();
    }
    return data;
  }
}

class DeletePartnersContactBookByPk {
  String? id;
  String? sTypename;

  DeletePartnersContactBookByPk({this.id, this.sTypename});

  DeletePartnersContactBookByPk.fromJson(Map<String, dynamic> json) {
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
