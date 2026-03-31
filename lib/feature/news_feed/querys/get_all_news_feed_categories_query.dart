const String getAllNewsfeedCategoriesQuery = r'''
query getAllNewsfeedCategories {
  newsfeed_categories(
    where: {community_id: {_is_null: true}}
    order_by: {created_at: desc}
  ) {
    id
    category_name
    __typename
  }
}
''';
