const String addNewsFeedLikeMutation = r'''
mutation insertRecord($fields: newsfeeds_likes_insert_input!) {
  insert_newsfeeds_likes_one(object: $fields) {
    id
    __typename
  }
}
''';

const String removeNewsFeedLikeMutation = r'''
mutation deleteRecord($id: uuid!) {
  delete_newsfeeds_likes_by_pk(id: $id) {
    id
    __typename
  }
}
''';