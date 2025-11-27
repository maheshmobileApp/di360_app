const String getPartnershipQuery = r'''query getRecordByField($value: uuid!) {
  directories(where: {community_id: {_eq: $value}}, limit: 1) {
    partnership_link
    __typename
  }
}
''';
