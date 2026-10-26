const String suppliesModuleDraftCountQuery =
    r'''query get_supply_aggregate_status_wise($dental_suppliers_id: uuid) {
  draft: supplies_aggregate(
    where: {status: {_eq: "DRAFT"}, dental_suppliers_id: {_eq: $dental_suppliers_id}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
