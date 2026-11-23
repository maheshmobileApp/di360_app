const String suppliesAggregateQuery =
    r'''query supplies_aggregate($andList: [supplies_bool_exp!]) {
  supplies_aggregate(where: {_and: $andList}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';

const String suppliesDraftAgrregateQuery =
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

const String suppliesApproveAgrregateQuery =
    r'''query get_supply_aggregate_status_wise($dental_suppliers_id: uuid) {
  approved: supplies_aggregate(
    where: {status: {_eq: "APPROVED"}, dental_suppliers_id: {_eq: $dental_suppliers_id}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
