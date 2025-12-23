const String getTalentListingStatusCountsQuery =
    r'''query getTalentHiringCountByStatus($where: jobhirings_bool_exp = {}) {
  all: jobhirings_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  pending: jobhirings_aggregate(
    where: {_and: [$where, {hiring_status: {_eq: "PENDING"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  approve: jobhirings_aggregate(
    where: {_and: [$where, {hiring_status: {_eq: "APPROVE"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: jobhirings_aggregate(
    where: {_and: [$where, {hiring_status: {_eq: "REJECT"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  cancelled: jobhirings_aggregate(
    where: {_and: [$where, {hiring_status: {_eq: "CANCELLED"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';
