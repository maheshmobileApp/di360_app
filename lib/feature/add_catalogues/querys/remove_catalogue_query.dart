const String removeCatalogueQuery = r'''
mutation removeCatelog($id: uuid!) {
  delete_catalogues(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';