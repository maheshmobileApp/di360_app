const String addCatalogueQuery = r'''
mutation demo($catalogueObj: catalogues_insert_input!) {
  insert_catalogues_one(object: $catalogueObj) {
    id
    __typename
  }
}
''';