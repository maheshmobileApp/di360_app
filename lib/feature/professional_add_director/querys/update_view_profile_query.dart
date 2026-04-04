const String updateViewProfileQuery = r'''
mutation updateRecord($id: uuid!, $changes: dental_professionals_set_input!) {
  update_dental_professionals_by_pk(pk_columns: {id: $id}, _set: $changes) {
    id
    __typename
  }
}
''';