const String partnershipRequestQuery =
    r'''mutation insertRecord($fields: partnership_members_insert_input!) {
  insert_partnership_members_one(object: $fields) {
    id
    __typename
  }
}
''';
