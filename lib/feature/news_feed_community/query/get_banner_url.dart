const String getBannerUrlQuery = r'''query getRecordByField($value: uuid!) {
  directories(where: {community_id: {_eq: $value}}, limit: 1) {
    banner_image
    __typename
  }
}''';
