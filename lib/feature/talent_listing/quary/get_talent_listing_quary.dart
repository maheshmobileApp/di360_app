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
      upload_resume
      job_location
      job_designation
      current_company
      current_ctc
      dental_professional_id
      post_anonymously
      admin_status
      profile_image
      profession_type
      work_type
      state
      city
      full_name
      languages_spoken
      availabilityOption
      availabilityDate
      Year_of_experiance
      availabilityDay
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
