const String getEnquiriesMessagesQuery =
    r'''query getAllApplicantsmessage($where: job_applicant_messages_bool_exp!, $limit: Int!) {
  job_applicant_messages(
    where: $where
    order_by: [{created_at: desc}, {id: desc}]
    limit: $limit
  ) {
    id
    job_applicant_id
    job_enquiry_id
    message
    created_at
    updated_at
    deleted_status
    sender_id
    receiver_id
    sender_type
    receiver_type
    __typename
  }
}''';
