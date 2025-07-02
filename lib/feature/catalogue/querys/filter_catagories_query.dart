const String filterCategoriesQuery = r'''
query getCatalogueCategoriesFront {
  catalogue_categories(where: {status: {_in: ["ACTIVE", "SCHEDULED"]}}) {
    id
    name
    __typename
  }
}
''';
