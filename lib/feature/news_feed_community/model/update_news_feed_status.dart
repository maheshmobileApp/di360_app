const String updateFeedStatusQuery =
    r'''mutation UpdateNewsfeedStatus($id: uuid!, $status: String!) {
  update_newsfeeds_by_pk(pk_columns: {id: $id}, _set: {status: $status}) {
    id
    status
    __typename
  }
}
''';
