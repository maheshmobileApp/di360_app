const String getAllNewsFeedQuery =
    r'''query getAllNewsfeeds($where: newsfeeds_bool_exp!, $limit: Int, $offset: Int, $userId: uuid, $roleType: String) {
  newsfeeds(
    where: $where
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    post_image
    community_id
    description
    category_type
    attachments
    feed_type
    payload
    user_role
    video_url
    web_url
    user_id
    status
    title
    dental_practice_id
    dental_professional_id
    dental_supplier_id
    dental_admin_id
    dental_supplier {
      id
      logo
      business_name
      profession_type
      email
      phone
      name
      type
      directories {
        id
        company_name
        logo
        description
        banner_image
        __typename
      }
      __typename
    }
    dental_professional {
      id
      name
      profession_type
      profile_image
      email
      phone
      type
      __typename
    }
    dental_practice {
      id
      logo
      business_name
      profession_type
      email
      phone
      name
      type
      directories {
        company_name
        logo
        description
        banner_image
        __typename
      }
      __typename
    }
    admin_user {
      id
      phone
      email
      __typename
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
    newsfeeds_likes {
      id
      dental_admin_id
      admin_user {
        id
        name
        __typename
      }
      dental_practice {
        business_name
        directories {
          id
          __typename
        }
        __typename
      }
      dental_supplier {
        business_name
        directories {
          id
          __typename
        }
        __typename
      }
      dental_professional {
        name
        directories {
          id
          __typename
        }
        __typename
      }
      __typename
    }
    my_like: newsfeeds_likes(
      where: {role_type: {_eq: $roleType}, _or: [{dental_supplier_id: {_eq: $userId}}, {dental_practice_id: {_eq: $userId}}, {dental_professional_id: {_eq: $userId}}, {dental_admin_id: {_eq: $userId}}]}
    ) {
      id
      __typename
    }
    newsfeeds_likes_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    news_feeds_comments(order_by: {created_at: desc}) {
      id
      comments
      created_at
      updated_at
      dental_admin_id
      comment_Pro_Img
      commenter_name
      comments_attachments
      comment_reply {
        id
        reply_text
        comment_id
        created_at
        reply_id
        reply_attachments
        dental_admin_id
        dental_practice_id
        dental_professional_id
        dental_supplier_id
        dental_supplier {
          name
          logo
          business_name
          directories {
            id
            logo
            __typename
          }
          __typename
        }
        dental_practice {
          name
          logo
          business_name
          directories {
            id
            logo
            __typename
          }
          __typename
        }
        dental_professional {
          name
          profile_image
          directories {
            id
            profile_image
            __typename
          }
          __typename
        }
        admin_user {
          name
          profile_image
          __typename
        }
        newsfeeds {
          id
          __typename
        }
        jobs {
          id
          __typename
        }
        courses {
          id
          __typename
        }
        __typename
      }
      dental_practice_id
      dental_professional_id
      dental_supplier_id
      dental_supplier {
        name
        logo
        business_name
        directories {
          id
          logo
          __typename
        }
        __typename
      }
      dental_practice {
        name
        logo
        business_name
        directories {
          id
          logo
          __typename
        }
        __typename
      }
      dental_professional {
        name
        profile_image
        directories {
          id
          profile_image
          __typename
        }
        __typename
      }
      admin_user {
        name
        profile_image
        __typename
      }
      newsfeed {
        id
        __typename
      }
      jobs {
        id
        __typename
      }
      courses {
        id
        __typename
      }
      __typename
    }
    news_feeds_comments_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    __typename
  }
}
''';
