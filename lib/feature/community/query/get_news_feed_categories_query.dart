const String getNewsFeedCategoriesQuery =
    r'''query getNewsfeedCategoriesByCommunity($communityId: uuid!) {
  newsfeed_categories(
    where: {community_id: {_eq: $communityId}}
    order_by: {created_at: desc}
  ) {
    id
    category_name
    created_at
    updated_at
    created_by
    created_by_user_id
    community_id
    __typename
  }
}
''';
