const String getJobStatusCount = r'''
query GetJobStatusCounts($supplierId: uuid!) {
  all: jobs_aggregate(
    where: { dental_supplier_id: { _eq: $supplierId } }
  ) {
    aggregate {
      count
    }
  }
  active: jobs_aggregate(
    where: {
      status: { _eq: "ACTIVE" }
      dental_supplier_id: { _eq: $supplierId }
    }
  ) {
    aggregate {
      count
    }
  }
  approved: jobs_aggregate(
    where: {
      status: { _eq: "APPROVE" }
      dental_supplier_id: { _eq: $supplierId }
    }
  ) {
    aggregate {
      count
    }
  }
  pending: jobs_aggregate(
    where: {
      status: { _eq: "PENDING" }
      dental_supplier_id: { _eq: $supplierId }
    }
  ) {
    aggregate {
      count
    }
  }
  rejected: jobs_aggregate(
    where: {
      status: { _eq: "REJECT" }
      dental_supplier_id: { _eq: $supplierId }
    }
  ) {
    aggregate {
      count
    }
  }
  inactive: jobs_aggregate(
    where: {
      status: { _eq: "INACTIVE" }
      dental_supplier_id: { _eq: $supplierId }
    }
  ) {
    aggregate {
      count
    }
  }
  draft: jobs_aggregate(
    where: {
      status: { _eq: "DRAFT" }
      dental_supplier_id: { _eq: $supplierId }
    }
  ) {
    aggregate {
      count
    }
  }
  scheduled: jobs_aggregate(
    where: {
      status: { _eq: "EXPIRED" }
      dental_supplier_id: { _eq: $supplierId }
    }
  ) {
    aggregate {
      count
    }
  }
  expired: jobs_aggregate(
    where: {
      status: { _eq: "EXPIRED" }
      dental_supplier_id: { _eq: $supplierId }
    }
  ) {
    aggregate {
      count
    }
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
