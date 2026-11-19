class accountRequestsRes {
  AccountRequestsData? data;

  accountRequestsRes({this.data});

  accountRequestsRes.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AccountRequestsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AccountRequestsData {
  List<SupplierAccountRequests>? supplierAccountRequests;

  AccountRequestsData({this.supplierAccountRequests});

  AccountRequestsData.fromJson(Map<String, dynamic> json) {
    if (json['supplier_account_requests'] != null) {
      supplierAccountRequests = <SupplierAccountRequests>[];
      json['supplier_account_requests'].forEach((v) {
        supplierAccountRequests!.add(new SupplierAccountRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplierAccountRequests != null) {
      data['supplier_account_requests'] =
          this.supplierAccountRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierAccountRequests {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? supplierId;
  String? dentalPracticeId;
  String? dentalProfessionalId;
  String? dentalSupplierId;
  String? name;
  String? practiceName;
  String? email;
  String? phone;
  String? abnNumber;
  String? billingAddress;
  String? notes;
  String? status;
  Supplier? supplier;
  String? sTypename;

  SupplierAccountRequests(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.supplierId,
      this.dentalPracticeId,
      this.dentalProfessionalId,
      this.dentalSupplierId,
      this.name,
       this.practiceName,
      this.email,
      this.phone,
      this.abnNumber,
      this.billingAddress,
      this.notes,
      this.status,
      this.supplier,
      this.sTypename});

  SupplierAccountRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    supplierId = json['supplier_id'];
    dentalPracticeId = json['dental_practice_id'];
    dentalProfessionalId = json['dental_professional_id'];
    dentalSupplierId = json['dental_supplier_id'];
    name = json['name'];
    practiceName = json['practice_name'];
    email = json['email'];
    phone = json['phone'];
    abnNumber = json['abn_number'];
    billingAddress = json['billing_address'];
    notes = json['notes'];
    status = json['status'];
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
    data['dental_practice_id'] = this.dentalPracticeId;
    data['dental_professional_id'] = this.dentalProfessionalId;
    data['dental_supplier_id'] = this.dentalSupplierId;
    data['name'] = this.name;
    data['practice_name'] = this.practiceName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['abn_number'] = this.abnNumber;
    data['billing_address'] = this.billingAddress;
    data['notes'] = this.notes;
    data['status'] = this.status;
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
