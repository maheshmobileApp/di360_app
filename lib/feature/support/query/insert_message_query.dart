const String insertMessageQuery =
    r'''mutation insert_support_requests_conversations($conversation: support_requests_conversations_insert_input!) {
  insert_support_requests_conversations_one(object: $conversation) {
    id
    __typename
  }
}
''';
