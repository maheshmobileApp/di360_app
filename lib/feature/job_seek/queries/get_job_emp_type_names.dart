const String getJobEmpTypeNames = r'''query getJobEmployeeType {
  job_types(order_by: {created_at: desc}) {
    id
    employee_type_name
    __typename
  }
}''';
