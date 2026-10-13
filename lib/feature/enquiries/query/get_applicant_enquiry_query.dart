const String getApplicantEnquiryQuery =
    r'''query getApplicantsEnquiry($where: job_enquiries_bool_exp!, $limit: Int!) {
  job_enquiries(
    where: $where
    order_by: [{created_at: desc}, {id: desc}]
    limit: $limit
  ) {
    id
    job_id
    created_at
    updated_at
    enq_sender_id
    enquiry_description
    __typename
  }
}
''';
