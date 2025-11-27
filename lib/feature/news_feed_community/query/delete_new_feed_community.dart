const String deleteNewsFeedCommunityQuery =
    r'''mutation DeleteNewsfeed($id: uuid!) {
  delete_newsfeeds_by_pk(id: $id) {
    id
    __typename
  }
  delete_comments_replies: delete_news_feeds_comments_replys(
    where: {news_feeds_id: {_eq: $id}}
  ) {
    affected_rows
    __typename
  }
}
''';
