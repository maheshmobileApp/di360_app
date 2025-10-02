const String jobProfileListing = r'''
query GetJobProfileData($dental_professional_id: uuid!) {
  job_profiles(
    where: {dental_professional_id: {_eq: $dental_professional_id}}
    order_by: {created_at: desc}
  ) {
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
      name
      email
      profession_type
      profile_image
      gender
    }
   jobhirings {
        id
        created_at
        dental_supplier_id
        dental_professional_id
        hiring_status
        job_profiles_id
      }
      talent_enquiries {
        id
        talent_id
        enquiry_description
        enquiry_from
        created_at
        updated_at
      }
  }
}
 ''';
