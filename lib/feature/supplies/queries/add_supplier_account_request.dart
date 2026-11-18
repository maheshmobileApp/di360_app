const String addSupplierAccountRequestQuery = r'''mutation add_supplier_account_request($supplier_account_request: supplier_account_requests_insert_input!) {
  insert_supplier_account_requests_one(object: $supplier_account_request) {
    id
    __typename
  }
}''';
