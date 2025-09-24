const String GetCatalogueCountsQuery = r'''
query get_all_supply_aggregate_status_wise_v2($dental_supplier_id: uuid) {
  all: catalogues_aggregate(
    where: {status: {_in: ["APPROVED", "PENDING_APPROVAL", "EXPIRED", "DRAFT", "SCHEDULED", "REJECTED"]}, dental_supplier_id: {_eq: $dental_supplier_id}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  draft: catalogues_aggregate(
    where: {status: {_eq: "DRAFT"}, dental_supplier_id: {_eq: $dental_supplier_id}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  approval_pending: catalogues_aggregate(
    where: {status: {_eq: "PENDING_APPROVAL"}, dental_supplier_id: {_eq: $dental_supplier_id}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  approved: catalogues_aggregate(
    where: {_and: [{catalogue_status: {_eq: "ACTIVE"}}, {status: {_in: ["APPROVED", "SCHEDULED"]}}, {dental_supplier_id: {_eq: $dental_supplier_id}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  scheduled: catalogues_aggregate(
    where: {status: {_eq: "SCHEDULED"}, dental_supplier_id: {_eq: $dental_supplier_id}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: catalogues_aggregate(
    where: {status: {_eq: "REJECTED"}, dental_supplier_id: {_eq: $dental_supplier_id}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  expired: catalogues_aggregate(
    where: {status: {_eq: "EXPIRED"}, dental_supplier_id: {_eq: $dental_supplier_id}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  inactive: catalogues_aggregate(
    where: {_and: [{catalogue_status: {_eq: "INACTIVE"}}, {status: {_in: ["APPROVED", "SCHEDULED"]}}, {dental_supplier_id: {_eq: $dental_supplier_id}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';