const String sendSupportRequestQuery =
    r'''mutation send_support_requests($support_request: support_requests_insert_input!) {
  insert_support_requests_one(object: $support_request) {
    id
    __typename
  }
}
''';
