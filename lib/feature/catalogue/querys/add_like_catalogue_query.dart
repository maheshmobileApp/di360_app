const String addLikeCatalogueQuery = r'''
mutation demo($favObj: catalogue_favorites_insert_input!) {
  insert_catalogue_favorites_one(object: $favObj) {
    id
    __typename
  }
}
''';
