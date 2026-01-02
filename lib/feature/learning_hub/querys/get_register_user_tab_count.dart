const String getRegisterUserTabCountQuery =
    r'''query getRegisterUserTabCounts($where: course_registered_users_bool_exp!) {
  all: course_registered_users_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  pending: course_registered_users_aggregate(
    where: {_and: [$where, {status: {_eq: "PENDING"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  approved: course_registered_users_aggregate(
    where: {_and: [$where, {status: {_eq: "APPROVED"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  cancelled: course_registered_users_aggregate(
    where: {_and: [$where, {status: {_eq: "CANCELLED"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  completed: course_registered_users_aggregate(
    where: {_and: [$where, {status: {_eq: "COMPLETED"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';
