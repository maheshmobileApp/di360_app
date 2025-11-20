const String updateProfileLogoQuery = r'''
mutation update_dental_suppliers_by_pk($id: uuid!, $userImage: dental_suppliers_set_input!) {
  update_dental_suppliers_by_pk(pk_columns: {id: $id}, _set: $userImage) {
    id
    __typename
  }
}
''';

const String updatePracticeProfileLogoQuery = r'''
mutation update_dental_practices_by_pk($id: uuid!, $userImage: dental_practices_set_input!) {
  update_dental_practices_by_pk(pk_columns: {id: $id}, _set: $userImage) {
    id
    __typename
  }
}
''';

const String updateProfessProfileLogoQuery = r'''
mutation update_dental_professionals_by_pk($id: uuid!, $userImage: dental_professionals_set_input!) {
  update_dental_professionals_by_pk(pk_columns: {id: $id}, _set: $userImage) {
    id
    __typename
  }
}
''';