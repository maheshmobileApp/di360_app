String getRequestCountQuery =
    r'''query getRequestCount($where: jobhirings_bool_exp!) {
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
  reject: jobhirings_aggregate(
    where: {_and: [$where, {hiring_status: {_eq: "REJECT"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
