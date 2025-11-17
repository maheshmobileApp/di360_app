const String talentListingMessagesQuery =
    r'''query getTalentsmessages($talent_id: uuid!) {
  talents_message(
    where: { talent_id: { _eq: $talent_id } }
    order_by: { created_at: desc }
  ) {
    id
    created_at
message
  message_from
attachments}
}''';
