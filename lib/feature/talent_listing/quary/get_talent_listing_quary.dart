const String getTalentListingQuery = r'''
query getTalentEnquiryList($where: talent_enquiries_bool_exp) {
  talent_enquiries(where: $where) {
    id
    created_at
    talent_id
    updated_at
    enquiry_description
    enquiry_from

    job_profiles {
      id
      created_at
      updated_at
      skills
      jobexperiences
      email_address
      mobile_number
      upload_resume
      educations
      location
      job_designation
      work_rights
      current_company
      certificate
      current_ctc
      abn_number
      dental_professional_id
      post_anonymously
      admin_status
      profile_image
      
      cover_letter
      profession_type
      work_type
      state
      city
      full_name
      salary_amount
      travel_distance
      about_yourself
      languages_spoken
      availabilityOption
      salary_type
      willing_to_travel
      availabilityDate
      availabilityType
      aphra_number
      availabilityDay
      areas_expertise
      unavailabilityDate
      dental_professional {
        id
        profile_image
        directories {
          id
          dental_professional_id
          logo
          profile_image
        }
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
}
''';

