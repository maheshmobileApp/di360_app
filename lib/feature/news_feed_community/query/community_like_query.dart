const String communityLikeQuery =
    r'''mutation insertRecord($fields: newsfeeds_likes_insert_input!) {
  insert_newsfeeds_likes_one(object: $fields) {
    id
    __typename
  }
}
''';
