const String catagorys_query = r'''
query getCatalogueSubCategories {
  catalogue_sub_categories(where: {status: {_eq: "ACTIVE"}}) {
    id
    name
    __typename
  }
}
''';