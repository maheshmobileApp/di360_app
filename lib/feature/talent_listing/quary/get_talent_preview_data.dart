const String getTalentPreviewDataQuery = r'''query getRelatedTalentListMutation($profession_type: String, $limit: Int!, $offset: Int!, $excludeId: uuid!) {
  job_profiles(
    where: {profession_type: {_eq: $profession_type}, id: {_neq: $excludeId}, admin_status: {_eq: "APPROVE"}, active_status: {_eq: "ACTIVE"}}
    limit: $limit
    offset: $offset
    order_by: [{created_at: desc}, {id: asc}]
  ) {
    id
    created_at
    updated_at
    dental_professional_id
    admin_status
    profile_image
    full_name
    mobile_number
    email_address
    skills
    jobexperiences
    educations
    upload_resume
    job_designation
    current_company
    current_ctc
    post_anonymously
    work_type
    profession_type
    location
    country
    city
    state
    cover_letter
    certificate
    radius
    abn_number
    availabilityType
    availabilityOption
    availabilityDate
    availabilityDay
    work_rights
    Year_of_experiance
    languages_spoken
    areas_expertise
    percentage
    salary_amount
    salary_type
    aphra_number
    willing_to_travel
    travel_distance
    about_yourself
    fromDate
    dental_professional {
      id
      gender
      __typename
    }
    jobhirings {
      id
      dental_supplier_id
      dental_practice_id
      hiring_status
      __typename
    }
    __typename
  }
}
''';
