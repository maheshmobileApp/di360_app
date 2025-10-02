const String getCourseStatusCount = r'''
query getCoursesCountByStatus($whereAll: courses_bool_exp = {}, $whereDraft: courses_bool_exp = {}, $where: courses_bool_exp = {}) {
  all: courses_aggregate(where: $whereAll) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  draft: courses_aggregate(where: $whereDraft) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  pending: courses_aggregate(where: {_and: [$where, {status: {_eq: "PENDING"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  active: courses_aggregate(
    where: {_and: [$where, {status: {_eq: "APPROVE"}, active_status: {_eq: "ACTIVE"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  inactive: courses_aggregate(
    where: {_and: [$where, {status: {_eq: "APPROVE"}, active_status: {_eq: "INACTIVE"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  expired: courses_aggregate(where: {_and: [$where, {status: {_eq: "EXPIRED"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  approve: courses_aggregate(where: {_and: [$where, {status: {_eq: "APPROVE"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: courses_aggregate(where: {_and: [$where, {status: {_eq: "REJECT"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}

''';
