class SupplierResponse {
  SupplierData? data;

  SupplierResponse({this.data});

  SupplierResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplierData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplierData {
  DentalSuppliersByPk? dentalSuppliersByPk;

  SupplierData({this.dentalSuppliersByPk});

  SupplierData.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? email;
  String? name;
  String? phone;
  String? firstName;
  String? lastName;
  String? sTypename;

  DentalSuppliersByPk(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.firstName,
      this.lastName,
      this.sTypename});

  DentalSuppliersByPk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
