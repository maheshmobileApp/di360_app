const String getEnquiriesMessagesQuery =
    r'''query getJobMessages($job_enquiry_id: uuid!) {
  job_applicant_messages(
    where: { job_enquiry_id: { _eq: $job_enquiry_id } }
  ) {
    id
    job_enquiry_id
    message
    message_from
    attachments
  }
}''';
