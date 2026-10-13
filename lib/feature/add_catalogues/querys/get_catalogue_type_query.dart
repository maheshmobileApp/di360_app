const String getCatalogueTypesQuery = r'''
query getCatalogueCategoriesFront {
  catalogue_categories(where: {status: {_eq: "ACTIVE"}}) {
    id
    name
    __typename
  }
}
''';