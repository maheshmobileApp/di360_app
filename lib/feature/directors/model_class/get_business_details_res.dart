class GetBusinessDetailsRes {
  GetBusinessDetailsData? data;

  GetBusinessDetailsRes({this.data});

  GetBusinessDetailsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new GetBusinessDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetBusinessDetailsData {
  DentalSuppliersByPk? dentalSuppliersByPk;

  GetBusinessDetailsData({this.dentalSuppliersByPk});

  GetBusinessDetailsData.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? businessName;
  String? sTypename;

  DentalSuppliersByPk(
      {this.firstName, this.lastName, this.businessName, this.sTypename});

  DentalSuppliersByPk.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
