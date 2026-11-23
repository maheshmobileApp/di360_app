class supplierAccountRes {
  SupplierAccountData? data;

  supplierAccountRes({this.data});

  supplierAccountRes.fromJson(Map<String, dynamic> json) {
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
  InsertSupplierAccountRequestsOne? insertSupplierAccountRequestsOne;

  SupplierAccountData({this.insertSupplierAccountRequestsOne});

  SupplierAccountData.fromJson(Map<String, dynamic> json) {
    insertSupplierAccountRequestsOne =
        json['insert_supplier_account_requests_one'] != null
            ? new InsertSupplierAccountRequestsOne.fromJson(
                json['insert_supplier_account_requests_one'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.insertSupplierAccountRequestsOne != null) {
      data['insert_supplier_account_requests_one'] =
          this.insertSupplierAccountRequestsOne!.toJson();
    }
    return data;
  }
}

class InsertSupplierAccountRequestsOne {
  String? id;
  String? sTypename;

  InsertSupplierAccountRequestsOne({this.id, this.sTypename});

  InsertSupplierAccountRequestsOne.fromJson(Map<String, dynamic> json) {
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
