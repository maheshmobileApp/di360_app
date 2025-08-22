const String getJobApplicantsQuary = r''' 
query getajobswithallprofiles($andList: [job_applicants_bool_exp!]) {
  job_applicants(
    where: { _and: $andList }
  ) {
    id
    job_id
    attachments
    status
    first_name
    city_name
    dental_professional_id
    
    dental_professional {
      name
      email
      phone
      last_name
      first_name
      profile_image
      created_at
    }
    
    job_applicant_messages {
      id
      message
      message_from
      job_applicant_id
      job_enquiry_id
    }
    
    job_enquiries {
      id
      enquiry_userid
      enquiry_description
      job_id
    }
  }
}
''';