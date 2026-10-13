const String getJobApplicantsQuary = r'''
query getFilteredApplicants($limit: Int, $offset: Int, $where: job_applicants_bool_exp) {
  job_applicants(
    limit: $limit
    offset: $offset
    order_by: {updated_at: desc}
    where: $where
  ) {
    id
    job_id
    attachments
    status
    first_name
    city_name
    dental_professional_id
    dental_professional {
      name
      email
      phone
      last_name
      first_name
      profile_image
      created_at
      __typename
    }
    job_enquiries_find {
      id
      __typename
    }
    __typename
  }
}
''';
