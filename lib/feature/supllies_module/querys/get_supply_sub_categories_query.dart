const String getSupplySubCategoriesQuery = r'''query get_supply_sub_categories {
  supply_sub_categories(where: {status: {_eq: "ACTIVE"}}, order_by: {name: asc}) {
    id
    name
    created_at
    updated_at
    __typename
  }
}''';
