const String checkVisibilityQuery = r'''
query CHECK_VISIBILITY($limit: Int, $offset: Int, $where: directory_followers_bool_exp) {
  directory_followers(order_by: {updated_at: asc}, where: $where) {
    id
    __typename
  }
}
''';