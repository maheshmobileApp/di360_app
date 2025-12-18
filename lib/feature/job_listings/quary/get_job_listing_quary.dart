const String getJobListingQuary = r'''
query getalljobs($andList: [jobs_bool_exp!]) {
  jobs(
    where: { _and: $andList }
    order_by: { created_at: desc }
  ) {
    id
    title
    j_type
    j_role
    description
    TypeofEmployment
    availability_date
    auto_expiry_date 
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
    updated_at
    job_applicants_aggregate {
      aggregate {
        count
      }
    }
  }
}''';


