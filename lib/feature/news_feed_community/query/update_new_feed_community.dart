const String updateNewsFeedCommunityQuery =
    r'''mutation updateRecord($id: uuid!, $fields: newsfeeds_set_input!) {
  update_newsfeeds_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';
