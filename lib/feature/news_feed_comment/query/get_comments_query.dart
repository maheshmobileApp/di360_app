const String getCommentsQuery =
    r'''query Comments($feedId: uuid!, $limit: Int!, $offset: Int!) {
  news_feeds_comments(
    where: {news_feeds_id: {_eq: $feedId}, parent_comment_id: {_is_null: true}}
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    comment_text
    created_at
    created_by_id
    role_type
    attachments
    parent_comment_id
    replies_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    dental_professional {
      id
      name
      profile_image
      __typename
    }
    dental_practice {
      id
      business_name
      logo
      __typename
    }
    dental_supplier {
      id
      business_name
      logo
      __typename
    }
    admin_user {
      id
      name
      profile_image
      __typename
    }
    __typename
  }
}''';
