const String getTalentListingQuery = r'''
query getFiltredTalentList($where: job_profiles_bool_exp, $limit: Int, $offset: Int) {
  job_profiles(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {updated_at: desc}
  ) {
    id
    admin_status
    active_status
    current_company
    created_at
    updated_at
    skills
    jobexperiences
    job_designation
    dental_professional_id
    profile_image
    full_name
    work_type
    profession_type
    location
    country
    city
    state
    fromDate
    dental_professional {
      id
      __typename
    }
    jobhirings {
      id
      __typename
    }
    __typename
  }
}
''';
