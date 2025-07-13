const String getAllJobsRoleListQuery = r'''
query getAllJobsRoleList {
  jobs_role_list(order_by: {created_at: desc}) {
    id
    role_name
    created_at
    updated_at
    created_by
    created_by_user_id
    __typename
  }
}
''';
