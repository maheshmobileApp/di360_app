const String reportNewsfeedCommunityQuery =
    r'''mutation insertRecord($fields: newsfeed_user_action_insert_input!) {
  insert_newsfeed_user_action_one(object: $fields) {
    id
    __typename
  }
}''';
