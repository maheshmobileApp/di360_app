const String send_approval_query = r'''
mutation updateCatelogStatus($id: uuid!, $updateObj: catalogues_set_input!) {
  update_catalogues_by_pk(pk_columns: {id: $id}, _set: $updateObj) {
    id
    __typename
  }
}
''';