const String communityRegisterQuery =
    r'''mutation insertRecord($fields: community_members_insert_input!) {
  insert_community_members_one(object: $fields) {
    id
    __typename
  }
}
''';
