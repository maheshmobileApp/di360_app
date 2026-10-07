const String getSupplierQuery = r'''query getSupplierV2($id: uuid!) {
  dental_suppliers_by_pk(id: $id) {
    id
    name
    business_name
    __typename
  }
}
''';
