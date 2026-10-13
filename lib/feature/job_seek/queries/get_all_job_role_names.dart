const String getAllJobRoleNames = r'''query getAllJobsRoleName {
  jobs_role_list(order_by: {created_at: desc}) {
    id
    role_name
    __typename
  }
}''';
