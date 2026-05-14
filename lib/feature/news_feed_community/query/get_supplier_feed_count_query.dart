const String getSupplierFeedCount =r'''query GET_NEWSFEED_COUNTS($where: newsfeeds_bool_exp!) {
  pendingNews: newsfeeds_aggregate(
    where: {_and: [{status: {_eq: "PENDING"}}, $where]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  publishedNews: newsfeeds_aggregate(
    where: {_and: [{status: {_eq: "PUBLISHED"}}, $where]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  unpublishedNews: newsfeeds_aggregate(
    where: {_and: [{status: {_eq: "UNPUBLISHED"}}, $where]}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';
