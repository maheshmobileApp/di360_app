const String updateDirectorToViewProfile = r'''
mutation updateRecord($id: uuid!, $changes: directories_set_input!) {
  update_directories_by_pk(pk_columns: {id: $id}, _set: $changes) {
    id
    name
    email
    phone
    __typename
  }
}
''';