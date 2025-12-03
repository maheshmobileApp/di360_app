const String addNewsFeedCommentQuery =
    r'''mutation addNewsFeedComments($addCommentsData: news_feeds_comments_insert_input!) {
  insert_news_feeds_comments_one(object: $addCommentsData) {
    id
    comments
    __typename
  }
}
''';
