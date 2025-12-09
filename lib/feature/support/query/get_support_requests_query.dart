const String getSupportRequestsQuery = r'''
  query get_support_requests($andList: [support_requests_bool_exp!], $limit: Int, $offset: Int) {
  support_requests(
    where: {_and: $andList}
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    supplies_order_id
    supplies_order {
      id
      order_number
      __typename
    }
    second_hand_supplies_order_id
    second_hand_supplies_order {
      id
      order_number
      __typename
    }
    reason
    message
    attachments
    status
    reply
    reply_attachments
    support_request_number
    type
    dental_practice {
      type
      business_name
      email
      logo
      __typename
    }
    dental_supplier {
      type
      business_name
      email
      logo
      __typename
    }
    dental_professional {
      type
      name
      email
      profile_image
      __typename
    }
    __typename
  }
}
''';