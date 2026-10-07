const String jobTalentMessageListing =
    r'''query getAllTalentsmessage($where: talents_message_bool_exp!, $limit: Int!) {
  talents_message(
    where: $where
    order_by: [{created_at: desc}, {id: desc}]
    limit: $limit
  ) {
    id
    message
    created_at
    updated_at
    deleted_status
    talent_id
    sender_id
    receiver_id
    sender_type
    receiver_type
    jobhirings_id
    talent_enquiry_id
    __typename
  }
}''';