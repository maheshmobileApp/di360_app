const String getSupplierFeedCount =r'''query TestSupplierCommunityFeedCounts($community_id: uuid!) {
  published: newsfeeds_aggregate(
    where: {
      community_id: { _eq: $community_id }
      status: { _eq: "PUBLISHED" }
    }
  ) {
    aggregate { count }
  }

  pending: newsfeeds_aggregate(
    where: {
      community_id: { _eq: $community_id }
      status: { _eq: "PENDING" }
    }
  ) {
    aggregate { count }
  }

  unpublished: newsfeeds_aggregate(
    where: {
      community_id: { _eq: $community_id }
      status: { _eq: "UNPUBLISHED" }
    }
  ) {
    aggregate { count }
  }
}
''';
