const String getAllCommunityNewsfeedQuery =
    r'''query GetCommunityNewsfeedsByWhere($where: newsfeeds_bool_exp!, $entryFeedWhere: newsfeeds_bool_exp, $limit: Int, $offset: Int, $userId: uuid!, $includeEntryFeed: Boolean!) {
  entryFeed: newsfeeds(where: $entryFeedWhere, limit: 1) @include(if: $includeEntryFeed) {
    ...FeedFields
    __typename
  }
  feedList: newsfeeds(
    where: $where
    order_by: {approved_at: desc}
    limit: $limit
    offset: $offset
  ) {
    ...FeedFields
    __typename
  }
}

fragment FeedFields on newsfeeds {
  id
  created_at
  description
  post_image
  feed_type
  image_url
  category_type
  community_type
  user_id
  status
  title
  web_url
  video_url
  payload_id
  user_role
  community_id
  comments_enabled
  community_owner {
    logo
    business_name
    community_id
    directories {
      id
      __typename
    }
    __typename
  }
  catalogues {
    status
    catalogue_category {
      name
      __typename
    }
    catalogue_sub_category {
      name
      __typename
    }
    __typename
  }
  courses {
    presenters
    address
    cpd_points
    type
    __typename
  }
  jobs {
    j_role
    location
    TypeofEmployment
    __typename
  }
  newsfeeds_likes_aggregate {
    aggregate {
      count
      __typename
    }
    __typename
  }
  news_feeds_comments_aggregate(where: {parent_comment_id: {_is_null: true}}) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  my_like: newsfeeds_likes(where: {created_by_id: {_eq: $userId}}) {
    id
    __typename
  }
  dental_professional {
    id
    name
    profile_image
    directories(limit: 1, order_by: {created_at: desc}) {
      id
      __typename
    }
    __typename
  }
  dental_practice {
    id
    business_name
    logo
    directories(limit: 1, order_by: {created_at: desc}) {
      id
      __typename
    }
    __typename
  }
  dental_supplier {
    id
    business_name
    logo
    email
    phone
    directories(limit: 1, order_by: {created_at: desc}) {
      id
      __typename
    }
    __typename
  }
  admin_user {
    id
    name
    profile_image
    __typename
  }
  __typename
}''';
