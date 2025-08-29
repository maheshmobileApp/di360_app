const String getTalentListingQuery = r'''
  query GetTalentData(
    $admin_status: [String!]!,
    $limit: Int,
    $offset: Int
  ) {
    job_profiles(
      where: { admin_status: { _in: $admin_status } },
      order_by: { created_at: desc },
      limit: $limit,
      offset: $offset
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
      percentage
      salary_amount
      salary_type
      aphra_number
      willing_to_travel
      travel_distance
      about_yourself
      availabilityType
      unavailabilityDate

      dental_professional {
        id
        gender
      }

      jobhirings {
        id
 
 }
 }
 }
''';
