const String reportQuery = r'''
mutation singleFeedBlock($id: uuid!) {
  update_newsfeeds(
    where: { id: { _eq: $id } }
    _set: { feed_block: true }
  ) {
    affected_rows
    returning {
    id
      feed_block
    }
  }
}
''';