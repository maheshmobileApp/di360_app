const String getSupplierFeedCount =r'''query SupplierCommunityFeedsCount($where: newsfeeds_bool_exp!) {
  newsfeeds_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
