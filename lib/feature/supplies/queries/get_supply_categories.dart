const String getSupplyCategoriesQuery = r'''query supply_categories {
  supply_categories(where: {status: {_eq: "ACTIVE"}}) {
    id
    name
    supply_sub_categories(where: {status: {_eq: "ACTIVE"}}) {
      id
      name
      __typename
    }
    __typename
  }
}''';
