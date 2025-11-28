const String addNeedFeedQuery =
    r'''mutation insertRecord($fields: newsfeeds_insert_input!) {
  insert_newsfeeds_one(object: $fields) {
    id
    __typename
  }
}
''';
