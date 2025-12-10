const String getSupportRequestReasonsQuery =
    r'''query get_support_request_reasons {
  support_request_reasons {
    id
    created_at
    updated_at
    name
    __typename
  }
}
''';
