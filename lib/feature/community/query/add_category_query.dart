const String addCategoryQuery =
    r'''mutation insertRecord($fields: newsfeed_categories_insert_input!) {
  insert_newsfeed_categories_one(object: $fields) {
    id
    __typename
  }
}
''';
