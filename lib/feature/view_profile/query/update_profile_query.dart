const String updateViewProfileDataQuery = r'''
mutation addSupplier($id: uuid!, $supplierObj: dental_suppliers_set_input!) {
  update_dental_suppliers(where: {id: {_eq: $id}}, _set: $supplierObj) {
    affected_rows
    __typename
  }
}
''';

const String updatePracticeViewProfileDataQuery = r'''
mutation addPractice($id: uuid!, $practiceObj: dental_practices_set_input!) {
  update_dental_practices(where: {id: {_eq: $id}}, _set: $practiceObj) {
    affected_rows
    __typename
  }
}
''';

const String updateProfessionalProfileDataQuery = r'''
mutation update_dental_professionals_by_pk($id: uuid!, $_set: dental_professionals_set_input!) {
  update_dental_professionals_by_pk(pk_columns: {id: $id}, _set: $_set) {
    id
    __typename
  }
}
''';
