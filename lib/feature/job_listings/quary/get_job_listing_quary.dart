const String getJobListingQuary = r'''
query getJobListing($limit: Int, $offset: Int, $where: jobs_bool_exp) {
  jobs(
    limit: $limit
    offset: $offset
    order_by: {updated_at: desc}
    where: $where
  ) {
    id
    title
    description
    TypeofEmployment
    dental_practice_id
    dental_supplier_id
    active_status
    logo
    company_name
    j_role
    status
    created_at
    location
    job_applicants_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    job_enquiries_aggregate(distinct_on: enq_sender_id) {
      aggregate {
        count
        __typename
      }
      __typename
    }
    __typename
  }
}
''';