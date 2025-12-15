const String getApplicantEnquiryQuery =
    r'''query getApplicantsEnquiry($where: job_enquiries_bool_exp!) {
  job_enquiries(where: $where, order_by: {created_at: asc}) {
    id
    job_id
    created_at
    updated_at
    enquiry_userid
    enquiry_description
    __typename
  }
}
''';
