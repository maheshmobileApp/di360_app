const String editCatalogueQuery = r'''
mutation updateCatelog($id: uuid!, $updateObj: catalogues_set_input!) {
  update_catalogues_by_pk(pk_columns: {id: $id}, _set: $updateObj) {
    id
    __typename
  }
}
''';