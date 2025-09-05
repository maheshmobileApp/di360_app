const String GetTalentStatusCountsQuery = r'''
query getTalentAdminCountByStatus($whereAll: job_profiles_bool_exp = {}, $where: job_profiles_bool_exp = {}) {
  all: job_profiles_aggregate(where: $whereAll) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  pending: job_profiles_aggregate(
    where: {_and: [$where, {admin_status: {_eq: "PENDING"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  approve: job_profiles_aggregate(
    where: {_and: [$where, {admin_status: {_eq: "APPROVE"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  rejected: job_profiles_aggregate(
    where: {_and: [$where, {admin_status: {_eq: "REJECT"}}]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}

  ''';

