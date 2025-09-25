const String getFilterTypesQuery = r'''
query getCatalogueTypeOptions {
  catalogue_categories {
    id
    name
    __typename
  }
}
''';


const String getFilterCategoriesQuery = r'''
query getCatalogueCategoryOptions {
  catalogue_sub_categories {
    id
    name
    __typename
  }
}
''';