const String getFilteredEnquiryQuery =
    r'''query getJobFilteredEnquiry($limit: Int, $offset: Int, $where: job_enquiries_bool_exp) {
  job_enquiries(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {enquiry_userid: desc, created_at: asc}
    distinct_on: enquiry_userid
  ) {
    id
    job_id
    enquiry_userid
    enquiry_description
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
    job_profiles {
      profile_image
      full_name
      upload_resume
      profession_type
      location
      country
      __typename
    }
    job_applicants_find {
      id
      __typename
    }
    __typename
  }
}''';
