const String filterSuppilerQuery = r'''
query dental_suppliers {
  dental_suppliers(where: {catalogues_aggregate: {count: {predicate: {_gt: 0}}}}) {
    id
    name
    logo
    business_name
    profession_type
    directories {
      name
      __typename
    }
    __typename
  }
}
''';