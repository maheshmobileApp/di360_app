const String deleteSupplierAccessQuery =
    r'''mutation deleteSupplierAccess($where: supplier_access_bool_exp!) {
  delete_supplier_access(where: $where) {
    affected_rows
    __typename
  }
}''';
