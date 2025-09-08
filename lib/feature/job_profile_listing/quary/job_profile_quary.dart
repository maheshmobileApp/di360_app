const String  jobProfileListing = r''' 
query GetJobProfileData($dental_professional_id: uuid!) {
  job_profiles(
    where: {dental_professional_id: {_eq: $dental_professional_id}}
    order_by: {created_at: desc}
  ) {
    id
    created_at
    updated_at
    job_designation
    current_company
    dental_professional_id
    post_anonymously
    admin_status
    active_status
    profile_image
    full_name
    work_type
    profession_type
    availabilityOption
    availabilityDate
    fromDate
    availabilityDay
    availabilityType
    unavailabilityDate
    dental_professional {
      id
      name
      email
      profession_type
      profile_image
      gender
    }
    jobhirings {
      id
    }
  }
}


 ''';