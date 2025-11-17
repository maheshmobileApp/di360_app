const String updateProfileLogoQuery = r'''
mutation update_dental_suppliers_by_pk($id: uuid!, $userImage: dental_suppliers_set_input!) {
  update_dental_suppliers_by_pk(pk_columns: {id: $id}, _set: $userImage) {
    id
    __typename
  }
}
''';
