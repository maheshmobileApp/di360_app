const String addNewsFeedLikeMutation = r'''
mutation addNewsFeedLikes($addLikes: newsfeeds_likes_insert_input!) {
  insert_newsfeeds_likes_one(object: $addLikes) {
    id
    __typename
  }
}
''';

const String removeNewsFeedLikeMutation = r'''
mutation removeNewsfeedLikes($userId: uuid, $feedId: uuid) {
  delete_newsfeeds_likes(
    where: {
      _or: [
        { dental_supplier_id: { _eq: $userId } },
        { dental_practice_id: { _eq: $userId } },
        { dental_professional_id: { _eq: $userId } },
        { dental_admin_id: { _eq: $userId } }
      ],
      news_feeds_id: { _eq: $feedId }
    }
  ) {
    affected_rows
  }
}
''';