const String getTalentEnquiryQuery = r'''
query getMyEnquiryJobData($limit: Int, $offset: Int, $where: talent_enquiries_bool_exp) {
  talent_enquiries(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {talent_id: desc, created_at: asc}
    distinct_on: talent_id
  ) {
    id
    created_at
    talent_id
    enquiry_from
    dental_practices {
      logo
      __typename
    }
    job_profiles {
      id
      full_name
      profession_type
      state
      profile_image
      work_type
      dental_professional_id
      post_anonymously
      dental_professional {
        profile_image
        gender
        __typename
      }
      __typename
    }
    jobhirings_find_practice {
      id
      __typename
    }
    jobhirings_find_supplier {
      id
      __typename
    }
    __typename
  }
}

''';





