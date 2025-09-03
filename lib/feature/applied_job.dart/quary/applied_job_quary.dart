const String appliedJobQuery = r'''
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
''';
