const String getRepliesQuery =
    r'''query Replies($parentId: uuid!, $limit: Int!, $offset: Int!) {
  news_feeds_comments(
    where: {parent_comment_id: {_eq: $parentId}}
    limit: $limit
    offset: $offset
  ) {
    id
    comment_text
    created_at
    parent_comment_id
    created_by_id
    role_type
    attachments
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
