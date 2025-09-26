const String getCatalogueTypesQuery = r'''
query getCatalogueSubCategories {
  catalogue_categories(where: {status: {_eq: "ACTIVE"}}) {
    id
    name
    __typename
  }
}
''';