const String getSupplyBrandsQuery = r'''query supply_brands {
  supply_brands(where: {status: {_eq: "ACTIVE"}}) {
    id
    created_at
    updated_at
    name
    __typename
  }
}''';
