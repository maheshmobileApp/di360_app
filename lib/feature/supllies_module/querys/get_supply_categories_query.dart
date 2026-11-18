const String getSupplyCategoriesQuery = r'''query get_supply_categories {
  supply_categories(where: {status: {_eq: "ACTIVE"}}, order_by: {name: asc}) {
    id
    name
    created_at
    updated_at
    __typename
  }
}''';
