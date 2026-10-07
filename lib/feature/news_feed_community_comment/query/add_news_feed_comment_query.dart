const String addNewsFeedCommentQuery =
    r'''mutation InsertComment($object: news_feeds_comments_insert_input!) {
  insert_news_feeds_comments_one(object: $object) {
    id
    parent_comment_id
    comment_text
    created_at
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
}
''';
