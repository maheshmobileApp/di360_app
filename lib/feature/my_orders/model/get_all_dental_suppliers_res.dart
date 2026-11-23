class getAllDentalSupliersRes {
  AllDentalSuppliersData? data;

  getAllDentalSupliersRes({this.data});

  getAllDentalSupliersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new AllDentalSuppliersData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AllDentalSuppliersData {
  List<DentalSuppliers>? dentalSuppliers;

  AllDentalSuppliersData({this.dentalSuppliers});

  AllDentalSuppliersData.fromJson(Map<String, dynamic> json) {
    if (json['dental_suppliers'] != null) {
      dentalSuppliers = <DentalSuppliers>[];
      json['dental_suppliers'].forEach((v) {
        dentalSuppliers!.add(new DentalSuppliers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dentalSuppliers != null) {
      data['dental_suppliers'] =
          this.dentalSuppliers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DentalSuppliers {
  String? id;
  String? name;
  String? phone;
  String? email;
  dynamic? profileImage;
  String? businessName;
  String? sTypename;

  DentalSuppliers(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.profileImage,
      this.businessName,
      this.sTypename});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    profileImage = json['profile_image'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
