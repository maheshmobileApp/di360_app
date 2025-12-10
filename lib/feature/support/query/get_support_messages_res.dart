const String getSupportMessagesQuery =
    r'''query GetMessagesBySupportRequest($supportRequestId: uuid!) {
  support_requests_conversations
(
    where: { support_request_id: { _eq: $supportRequestId } }
    order_by: { created_at: asc }
  ) {
    id
    message
    sender_id
    sender_type
    created_at
    updated_at
    attachments
    support_request_id
  }
}''';
