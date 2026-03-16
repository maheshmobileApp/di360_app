const String getBannersCountQuery = r'''
query GetBannerCounts($adminId: uuid!) {
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
  approved: banners_aggregate(where: {status: {_eq: "APPROVED"}}) {
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
