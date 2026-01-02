const String getAllJobsFilterQuery = r'''query getJobList($limit: Int, $offset: Int, $where: jobs_bool_exp, $order_by: [jobs_order_by!]) {
  jobs(where: $where, order_by: $order_by, limit: $limit, offset: $offset) {
    id
    title
    j_type
    j_role
    dental_supplier_id
    dental_practice_id
    description
    TypeofEmployment
    availability_date
    auto_expiry_date
    years_of_experience
    active_status
    location
    logo
    state
    city
    company_name
    status
    country
    banner_image
    created_at
    __typename
  }
}
''';
