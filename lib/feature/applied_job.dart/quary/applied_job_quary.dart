const String appliedJobQuery = r'''
query getajobswithallprofiles($id: [uuid!], $limit: Int, $offset: Int) {
  jobs(where: {id: {_in: $id}}, limit: $limit, offset: $offset) {
    id
    title
    j_type
    j_role
    description
    TypeofEmployment
    years_of_experience
    dental_practice_id
    dental_supplier_id
    active_status
    location
    logo
    state
    city
    salary
    company_name
    website_url
    pay_range
    education
    video
    closed_at
    status
    offered_benefits
    country
    endDateToggle
    pay_max
    pay_min
    hiring_period
    no_of_people
    rate_billing
    linkedin_url
    instagram_url
    facebook_url
    clinic_logo
    timings
    banner_image
    timingtoggle
    created_at
    job_applicants_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    job_applicants {
      id
      job_id
      status
      dental_professional_id
      message
      __typename
    }
    job_enquiries {
      id
      enquiry_userid
      enquiry_description
      job_id
      __typename
    }
    __typename
    }
    }
''';
