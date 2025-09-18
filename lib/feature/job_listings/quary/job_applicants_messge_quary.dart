const String jobListingApplicantMessge = r'''
query getAllApplicantsmessage($job_applicant_id: uuid!) {
    job_applicant_messages(  
        where: { job_applicant_id
: { _eq: $job_applicant_id } } 
        order_by: { created_at: asc }) {
        id
        job_applicant_id
        job_enquiry_id  
        message
        message_from
        created_at
        updated_at
        deleted_status
      }
   
  }
''';
/*

query getAllApplicantsmessage($job_id: uuid!) {
    job_applicant_messages(  
        where: { job_applicant: { id: { _eq: $job_id } } }
        order_by: { created_at: asc }) {
        id
        job_applicant_id
        job_enquiry_id  
        message
        message_from
        created_at
        updated_at
        deleted_status
      }
   
  }
 */