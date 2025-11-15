const String updateViewProfileDataQuery = r'''
mutation addSupplier($id: uuid!, $supplierObj: dental_suppliers_set_input!) {
  update_dental_suppliers(where: {id: {_eq: $id}}, _set: $supplierObj) {
    affected_rows
    __typename
  }
}
''';
