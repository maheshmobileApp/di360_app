const String getNewsFeedCategoriesQuery =
    r'''query getAllNewsfeedCategories($where: newsfeed_categories_bool_exp!, $limit: Int!, $offset: Int!) {
  newsfeed_categories(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
  ) {
    id
    category_name
    __typename
  }
  newsfeed_categories_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';
