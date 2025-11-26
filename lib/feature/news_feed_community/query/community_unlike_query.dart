const String communityUnlikeQuery = r'''mutation deleteRecord($id: uuid!) {
  delete_newsfeeds_likes_by_pk(id: $id) {
    id
    __typename
  }
}
''';
