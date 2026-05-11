const String updateCommentQuery = r'''
mutation EditComment($id: uuid!, $_set: news_feeds_comments_set_input!) {
  update_news_feeds_comments_by_pk(pk_columns: {id: $id}, _set: $_set) {
    id
    comment_text
    __typename
  }
}
''';