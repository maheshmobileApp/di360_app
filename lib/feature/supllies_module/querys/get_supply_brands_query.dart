const String getSupplyBrandsQuery = r'''query get_supply_brands {
  supply_brands(where: {status: {_eq: "ACTIVE"}}, order_by: {name: asc}) {
    id
    name
    created_at
    updated_at
    __typename
  }
}''';
