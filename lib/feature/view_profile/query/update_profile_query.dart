const String updateViewProfileDataQuery = r'''
mutation UpdateSupplier($id: uuid!, $set: dental_suppliers_set_input!) {
  update_dental_suppliers(where: {id: {_eq: $id}}, _set: $set) {
    affected_rows
    __typename
  }
}
''';

const String updatePracticeViewProfileDataQuery = r'''
mutation UpdatePractice($id: uuid!, $set: dental_practices_set_input!) {
  update_dental_practices(where: {id: {_eq: $id}}, _set: $set) {
    affected_rows
    __typename
  }
}
''';

const String updateProfessionalProfileDataQuery = r'''
mutation UpdateDentalProfessional($id: uuid!, $set: dental_professionals_set_input!) {
  update_dental_professionals_by_pk(pk_columns: {id: $id}, _set: $set) {
    id
    __typename
  }
}
''';
