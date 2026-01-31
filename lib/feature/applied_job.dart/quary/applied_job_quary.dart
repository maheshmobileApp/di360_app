const String appliedJobQuery =
    r'''query getmyAppliedJobData($limit: Int, $offset: Int, $where: job_applicants_bool_exp) {
  job_applicants(
    limit: $limit
    offset: $offset
    order_by: {updated_at: desc}
    where: $where
  ) {
    id
    created_at
    job_id
    status
    dental_professional_id
    dental_professional {
      profile_image
      __typename
    }
    job {
      id
      title
      logo
      company_name
      j_role
      TypeofEmployment
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
/*
r'''
query getajobswithallprofiles($dental_professional_id:uuid) {  
  job_applicants( where: {_and: [{ dental_professional_id: {_eq: $dental_professional_id}}]}){
  id
  job_id
  attachments
  status
  message
   dental_professional_id
    job{
      id
    title
    j_type
    j_role
    description
    TypeofEmployment
    years_of_experience
    dental_practice_id
    dental_supplier_id
    location
    logo
    state
    city
    company_name
    salary
    website_url
    pay_range
    education
    video
    rate_billing
    created_at
    job_applicants_aggregate {
      aggregate {
        count
      }
    }
    country
    days_of_week
    current_company
    endDateToggle
    experience
    facebook_url
    hiring_period
    instagram_url
    is_featured
    closing_message
    closed_at
    clinic_logo
    banner_image
    availability_date
    address
    active_status,
    pay_min,
    pay_max,
      job_enquiries {
        id
        enquiry_userid
        enquiry_description
        job_id
      }
    }
  }
 }
''';*/

const String enquireJobListQuery = r'''
query getEnquiryList($dental_professional_id:uuid) {  
  jobs{
  id
    status
      
      id
    title
    j_type
    j_role
    description
    TypeofEmployment
    years_of_experience
    dental_practice_id
    dental_supplier_id
    location
    logo
    state
    city
    company_name
    salary
    website_url
    pay_range
    education
    video
    rate_billing
    created_at
    job_applicants_aggregate {
      aggregate {
        count
      }
    }
    country
    days_of_week
    current_company
    endDateToggle
    experience
    facebook_url
    hiring_period
    instagram_url
    is_featured
    closing_message
    closed_at
    clinic_logo
    banner_image
    availability_date
    address
    active_status,
    pay_min,
    pay_max,
      job_enquiries ( where: {_and: [{ enquiry_userid: {_eq: $dental_professional_id}}]}) {
        id
        enquiry_userid
        enquiry_description
        job_id
      }
    }
  }
''';
