const String addSupplierAccountQuery =
    r'''mutation add_supplier_account($supplier_account: supplier_accounts_insert_input!) {
  insert_supplier_accounts_one(object: $supplier_account) {
    id
    __typename
  }
}''';
