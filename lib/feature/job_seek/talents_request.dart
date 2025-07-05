String talentsRequest = r'''query GetJobProfileData {
  job_profiles(order_by: {created_at: desc}) {
    id
    created_at
    updated_at
    skills
    jobexperiences
    educations
    upload_resume
    job_designation
    current_company
    current_ctc
    dental_professional_id
    post_anonymously
    admin_status
    profile_image
    full_name
    mobile_number
    email_address
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
    availabilityOption
    availabilityDate
    fromDate
    availabilityDay
    work_rights
    Year_of_experiance
    languages_spoken
    areas_expertise
    skills
    percentage
    salary_amount
    salary_type
    aphra_number
    willing_to_travel
    travel_distance
    about_yourself
    location
    availabilityType
    unavailabilityDate
    dental_professional {
      id
      gender
      __typename
    }
    jobhirings {
      id
      __typename
    }
    __typename
  }
}''';

/*
mutation insert_Enquiry_one($object: talent_enquiries_insert_input!) {
  insert_talent_enquiries_one(object: $object) {
    id
    __typename
  }
}

{
  "object": {
    "enquiry_description": "Can u call me",
    "talent_id": "693105b7-030d-45c0-8dfc-4cffd5572451",
    "enquiry_from": "7306adc6-1efa-4a52-8c82-7e4e1922a5c5"
  }
}
 */