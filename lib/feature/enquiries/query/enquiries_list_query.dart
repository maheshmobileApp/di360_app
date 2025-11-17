const String enquiriesListQuery =
    r'''query getMyEnquiryJobData($limit: Int, $offset: Int, $where: job_enquiries_bool_exp) {
  job_enquiries(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {job_id: desc, created_at: asc}
    distinct_on: job_id
  ) {
    id
    job_id
    created_at
    enquiry_userid
    dental_professional {
      profile_image
      __typename
    }
    jobs {
      id
      title
      logo
      company_name
      j_role
      TypeofEmployment
      __typename
    }
    job_applicants_find {
      id
      __typename
    }
    __typename
  }
}
''';
