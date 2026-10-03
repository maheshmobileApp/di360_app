const String getBannersCountQuery = r'''query GetBannerCounts($adminId: uuid!) {
  all: banners_aggregate(
    where: {_or: [{status: {_neq: "DRAFT"}}, {status: {_eq: "DRAFT"}, from_id: {_eq: $adminId}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  draft: banners_aggregate(
    where: {status: {_eq: "DRAFT"}, from_id: {_eq: $adminId}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  pending: banners_aggregate(where: {status: {_eq: "PENDING"}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  active: banners_aggregate(
    where: {status: {_eq: "APPROVED"}, active_status: {_eq: "ACTIVE"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  inactive: banners_aggregate(
    where: {status: {_eq: "APPROVED"}, active_status: {_eq: "INACTIVE"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  scheduled: banners_aggregate(where: {status: {_eq: "SCHEDULED"}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: banners_aggregate(where: {status: {_eq: "REJECTED"}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  expired: banners_aggregate(where: {status: {_eq: "EXPIRED"}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';
