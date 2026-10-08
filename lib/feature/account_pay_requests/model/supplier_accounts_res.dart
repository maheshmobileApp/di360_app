class SupplierAccountsRes {
  SupplierAccountData? data;

  SupplierAccountsRes({this.data});

  SupplierAccountsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplierAccountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplierAccountData {
  List<SupplierAccounts>? supplierAccounts;

  SupplierAccountData({this.supplierAccounts});

  SupplierAccountData.fromJson(Map<String, dynamic> json) {
    if (json['supplier_accounts'] != null) {
      supplierAccounts = <SupplierAccounts>[];
      json['supplier_accounts'].forEach((v) {
        supplierAccounts!.add(new SupplierAccounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplierAccounts != null) {
      data['supplier_accounts'] =
          this.supplierAccounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierAccounts {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? supplierId;
  String? accountNumber;
  Supplier? supplier;
  String? sTypename;

  SupplierAccounts(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.supplierId,
      this.accountNumber,
      this.supplier,
      this.sTypename});

  SupplierAccounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    supplierId = json['supplier_id'];
    accountNumber = json['account_number'];
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['supplier_id'] = this.supplierId;
    data['account_number'] = this.accountNumber;
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supplier {
  String? id;
  String? name;
  String? businessName;
  String? sTypename;

  Supplier({this.id, this.name, this.businessName, this.sTypename});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    businessName = json['business_name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['business_name'] = this.businessName;
    data['__typename'] = this.sTypename;
    return data;
  }
}
