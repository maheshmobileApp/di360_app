const String getJobStatusCount = r'''
query getUserJobsTabCounts($where: jobs_bool_exp!) {
  all: jobs_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  pending: jobs_aggregate(where: {_and: [$where, {status: {_eq: "PENDING"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  active: jobs_aggregate(
    where: {_and: [$where, {status: {_eq: "APPROVE"}}, {active_status: {_eq: "ACTIVE"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  inactive: jobs_aggregate(
    where: {_and: [$where, {status: {_eq: "APPROVE"}}, {active_status: {_eq: "INACTIVE"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  expired: jobs_aggregate(where: {_and: [$where, {status: {_eq: "EXPIRED"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: jobs_aggregate(where: {_and: [$where, {status: {_eq: "REJECT"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  draft: jobs_aggregate(where: {_and: [$where, {status: {_eq: "DRAFT"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';

const String getJobStatusCountPractice = r'''
query getUserJobsTabCounts($where: jobs_bool_exp!) {
  all: jobs_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  pending: jobs_aggregate(where: {_and: [$where, {status: {_eq: "PENDING"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  active: jobs_aggregate(
    where: {_and: [$where, {status: {_eq: "APPROVE"}}, {active_status: {_eq: "ACTIVE"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  inactive: jobs_aggregate(
    where: {_and: [$where, {status: {_eq: "APPROVE"}}, {active_status: {_eq: "INACTIVE"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  expired: jobs_aggregate(where: {_and: [$where, {status: {_eq: "EXPIRED"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: jobs_aggregate(where: {_and: [$where, {status: {_eq: "REJECT"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  draft: jobs_aggregate(where: {_and: [$where, {status: {_eq: "DRAFT"}}]}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';
