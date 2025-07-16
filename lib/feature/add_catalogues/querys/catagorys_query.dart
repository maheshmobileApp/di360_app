const String catagorys_query = r'''
query catalogues($andList: [catalogues_bool_exp!]) {
  catalogue_categories {
    id
    name
    catalogues_aggregate(where: {_and: $andList}) {
      aggregate {
        count
        __typename
      }
      __typename
    }
    __typename
  }
}
''';