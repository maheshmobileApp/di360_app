const String removeLikeCatalogueQuery = r'''
mutation removeFavCats($id: uuid!) {
  delete_catalogue_favorites(where: {catalogue_id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';