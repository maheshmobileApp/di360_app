const String getMembershipQuery = r'''query getRecordByField($value: uuid!) {
  directories(where: {community_id: {_eq: $value}}, limit: 1) {
    membership_link
    __typename
  }
}
''';
