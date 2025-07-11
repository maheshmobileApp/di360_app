const String getAllEmployeeTypeListQuery = r'''
query getAllEmployeeTypeList {
  job_types(order_by: {created_at: desc}) {
    id
    employee_type_name
    created_at
    updated_at
    created_by
    created_by_user_id
    __typename
  }
}
''';
