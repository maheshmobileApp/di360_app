const String getBannerSupplierCountQuery =
    r'''query GetSupplierBannerCounts($supplierId: uuid!) {
  all: banners_aggregate(where: {from_id: {_eq: $supplierId}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  draft: banners_aggregate(
    where: {from_id: {_eq: $supplierId}, status: {_eq: "DRAFT"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  pending: banners_aggregate(
    where: {from_id: {_eq: $supplierId}, status: {_eq: "PENDING"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  active: banners_aggregate(
    where: {from_id: {_eq: $supplierId}, status: {_eq: "APPROVED"}, active_status: {_eq: "ACTIVE"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  inactive: banners_aggregate(
    where: {from_id: {_eq: $supplierId}, status: {_eq: "APPROVED"}, active_status: {_eq: "INACTIVE"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  scheduled: banners_aggregate(
    where: {from_id: {_eq: $supplierId}, status: {_eq: "SCHEDULED"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: banners_aggregate(
    where: {from_id: {_eq: $supplierId}, status: {_eq: "REJECTED"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  expired: banners_aggregate(
    where: {from_id: {_eq: $supplierId}, status: {_eq: "EXPIRED"}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
