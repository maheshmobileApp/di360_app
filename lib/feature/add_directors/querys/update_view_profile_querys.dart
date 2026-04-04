const String updateSupplierViewProfileQuery = r'''
mutation updateRecord($id: uuid!, $changes: dental_suppliers_set_input!) {
  update_dental_suppliers_by_pk(pk_columns: {id: $id}, _set: $changes) {
    id
    __typename
  }
}
''';

const String updatePracticeViewProfileQuery = r'''
mutation updateRecord($id: uuid!, $changes: dental_practices_set_input!) {
  update_dental_practices_by_pk(pk_columns: {id: $id}, _set: $changes) {
    id
    __typename
  }
}
''';
