const String getTalentEnqMessagesQuery =
    r'''query getTalentsEnquiry($where: talent_enquiries_bool_exp!, $limit: Int!) {
  talent_enquiries(
    where: $where
    limit: $limit
    order_by: [{created_at: desc}, {id: desc}]
  ) {
    id
    talent_id
    created_at
    updated_at
    enq_sender_id
    enquiry_description
    __typename
  }
}
''';
