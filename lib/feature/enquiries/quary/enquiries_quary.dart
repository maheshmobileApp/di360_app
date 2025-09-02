const String enquiriesJobQuery = r'''
query getajobswithallprofiles($dental_professional_id:uuid) {  
  job_applicants( where: {_and: [{ dental_professional_id: {_eq: $dental_professional_id}}]}){
  id
  job_id
  attachments
  status
  message
   dental_professional_id
    job{
      country
      company_name
      experience
      salary
      status
      banner_image
      TypeofEmployment
      active_status
      created_at
      clinic_logo
      description
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
