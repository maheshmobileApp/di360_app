class SupplierAccountPractice {
  SupplierAccountPracticeData? data;

  SupplierAccountPractice({this.data});

  SupplierAccountPractice.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SupplierAccountPracticeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SupplierAccountPracticeData {
  InsertSupplierAccountsOne? insertSupplierAccountsOne;

  SupplierAccountPracticeData({this.insertSupplierAccountsOne});

  SupplierAccountPracticeData.fromJson(Map<String, dynamic> json) {
    insertSupplierAccountsOne = json['insert_supplier_accounts_one'] != null
        ? new InsertSupplierAccountsOne.fromJson(
            json['insert_supplier_accounts_one'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.insertSupplierAccountsOne != null) {
      data['insert_supplier_accounts_one'] =
          this.insertSupplierAccountsOne!.toJson();
    }
    return data;
  }
}

class InsertSupplierAccountsOne {
  String? id;
  String? sTypename;

  InsertSupplierAccountsOne({this.id, this.sTypename});

  InsertSupplierAccountsOne.fromJson(Map<String, dynamic> json) {
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
