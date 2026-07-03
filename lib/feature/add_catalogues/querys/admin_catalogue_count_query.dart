const String adminCatalogueStatusCountQuery = r'''
query adminCatalogueStatusCounts {
  approval_pending: catalogues_aggregate(
    where: {status: {_eq: "PENDING_APPROVAL"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  approved: catalogues_aggregate(
    where: {_and: [{catalogue_status: {_eq: "ACTIVE"}}, {status: {_in: ["APPROVED", "SCHEDULED"]}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: catalogues_aggregate(where: {status: {_eq: "REJECTED"}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  expired: catalogues_aggregate(where: {status: {_eq: "EXPIRED"}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  inactive: catalogues_aggregate(
    where: {_and: [{catalogue_status: {_eq: "INACTIVE"}}, {status: {_in: ["APPROVED", "SCHEDULED"]}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  all: catalogues_aggregate(where: {status: {_neq: "DRAFT"}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';