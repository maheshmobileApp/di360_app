const String jobProfileListing = r'''
query GetJobProfileData($professionalId: uuid!) {
  job_profiles(
    where: {dental_professional_id: {_eq: $professionalId}}
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
      gender
      __typename
    }
    jobhirings {
      id
      dental_professional_id
      __typename
    }
    __typename
  }
}
 ''';
