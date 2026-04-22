const String getAllNewsfeedsQuery = r'''query GetNewsfeedsByWhere(
    $where: newsfeeds_bool_exp!,
    $limit: Int,
    $offset: Int,
    $userId: uuid!,
  ) {
    newsfeeds(
      where: $where
      order_by: { created_at: desc }
      limit: $limit
      offset: $offset
    ) {
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
      catalogues {
        id
        status

        catalogue_category{
          name
        }
        catalogue_sub_category {
          name
        }
      }
        
      courses {
      id
      presenters
      address
      cpd_points
      type
      course_banner_image
      __typename
    }
      jobs {
      id
      banner_image
      j_role
      location
      TypeofEmployment
      __typename
    }

      newsfeeds_likes_aggregate {
        aggregate { count }
      }
      news_feeds_comments_aggregate {
        aggregate { count }
      }

      my_like: newsfeeds_likes(
        where: {
          created_by_id: { _eq: $userId }
        }
      ) {
        id
      }

      dental_professional { id name profile_image }
      dental_practice { id business_name logo }
      dental_supplier { id business_name logo email phone }
      admin_user { id name }
    }
  }
''';
