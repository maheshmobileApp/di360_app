const String getJobDetailsById = r'''query getJobListMutationbyid($id: uuid!, $loginID: uuid!) {
  jobs(where: {id: {_eq: $id}}) {
    id
    title
    j_role
    description
    TypeofEmployment
    years_of_experience
    company_name
    location
    logo
    dental_practice_id
    dental_supplier_id
    state
    city
    website_url
    pay_range
    education
    country
    pay_max
    pay_min
    hiring_period
    no_of_people
    rate_billing
    linkedin_url
    instagram_url
    facebook_url
    video
    clinic_logo
    banner_image
    offered_benefits
    availability_date
    created_at
    user_role
    created_by_id
    dental_practice {
      directories {
        description
        __typename
      }
      __typename
    }
    job_applicants(where: {dental_professional_id: {_eq: $loginID}}) {
      id
      dental_professional_id
      __typename
    }
    dental_supplier {
      directories {
        description
        __typename
      }
      __typename
    }
    __typename
  }
}
''';
