class GetAccountTowardsSupplier {
  AccountData? data;

  GetAccountTowardsSupplier({this.data});

  GetAccountTowardsSupplier.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AccountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AccountData {
  List<SupplierAccounts>? supplierAccounts;

  AccountData({this.supplierAccounts});

  AccountData.fromJson(Map<String, dynamic> json) {
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
  String? accountNumber;
  String? supplierId;
  Supplier? supplier;
  Null? dentalSupplierId;
  Null? dentalSupplier;
  Null? dentalPracticeId;
  Null? dentalPractice;
  String? dentalProfessionalId;
  Supplier? dentalProfessional;
  String? sTypename;

  SupplierAccounts(
      {this.id,
      this.accountNumber,
      this.supplierId,
      this.supplier,
      this.dentalSupplierId,
      this.dentalSupplier,
      this.dentalPracticeId,
      this.dentalPractice,
      this.dentalProfessionalId,
      this.dentalProfessional,
      this.sTypename});

  SupplierAccounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['account_number'];
    supplierId = json['supplier_id'];
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
    dentalSupplierId = json['dental_supplier_id'];
    dentalSupplier = json['dental_supplier'];
    dentalPracticeId = json['dental_practice_id'];
    dentalPractice = json['dental_practice'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalProfessional = json['dental_professional'] != null
        ? new Supplier.fromJson(json['dental_professional'])
        : null;
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_number'] = this.accountNumber;
    data['supplier_id'] = this.supplierId;
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['dental_supplier'] = this.dentalSupplier;
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_practice'] = this.dentalPractice;
    data['dental_professional_id'] = this.dentalProfessionalId;
    if (this.dentalProfessional != null) {
      data['dental_professional'] = this.dentalProfessional!.toJson();
    }
    data['__typename'] = this.sTypename;
    return data;
  }
}

class Supplier {
  String? id;
  String? name;
  String? sTypename;

  Supplier({this.id, this.name, this.sTypename});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sTypename = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['__typename'] = this.sTypename;
    return data;
  }
}
