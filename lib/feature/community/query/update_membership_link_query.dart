const String updateMembershipLinkQuery =
    r'''mutation updateRecord($id: uuid!, $fields: directories_set_input!) {
  update_directories_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';



