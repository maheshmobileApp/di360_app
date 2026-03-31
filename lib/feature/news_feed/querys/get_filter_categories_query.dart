const String getFilterCategoriesQuery = '''
    query getAllNewsfeedCategories {
      newsfeed_categories(order_by: {created_at: desc}) {
        id
        category_name
        created_at
        updated_at
        created_by
        created_by_user_id
        __typename
      }
    }
  ''';