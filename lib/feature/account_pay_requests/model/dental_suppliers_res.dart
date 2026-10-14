class DentalSuppliersRes {
  DentalSuppliersData? data;

  DentalSuppliersRes({this.data});

  DentalSuppliersRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DentalSuppliersData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DentalSuppliersData {
  List<DentalSuppliers>? dentalSuppliers;

  DentalSuppliersData({this.dentalSuppliers});

  DentalSuppliersData.fromJson(Map<String, dynamic> json) {
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
  String? businessName;
  String? sTypename;

  DentalSuppliers({this.id, this.businessName, this.sTypename});

  DentalSuppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
