const String getNewsFeedsByCatalog = r'''
query getAllNewsfeedsCatalog($status: String!) {
  newsfeeds(
    where: {
      _and: [
        { feed_type: { _eq: "CATALOGUE" } }
        { status: { _eq: $status } }
      ]
    }
    order_by: { updated_at: desc }
  ) {
    id
    created_at
    post_image
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
    newsfeeds_likes {
      dental_admin_id
      admin_user {
        id
        name
        __typename
      }
      dental_practice {
        id
        name
        logo
        type
        profession_type
        __typename
      }
      dental_supplier {
        id
        name
        logo
        type
        profession_type
        __typename
      }
      dental_professional {
        id
        name
        profession_type
        type
        profile_image
        __typename
      }
      __typename
    }
    newsfeeds_likes_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    news_feeds_comments {
      id
      comments
      created_at
      dental_admin_id
      comment_Pro_Img
      commenter_name
      comments_attachments
      comment_reply {
        id
        reply_text
        comment_id
        reply_id
        reply_attachments
        dental_admin_id
        dental_practice_id
        dental_professional_id
        dental_supplier_id
        dental_supplier {
          name
          logo
          directories {
            id
            __typename
          }
          __typename
        }
        dental_practice {
          name
          logo
          directories {
            id
            __typename
          }
          __typename
        }
        dental_professional {
          name
          profile_image
          directories {
            id
            __typename
          }
          __typename
        }
        admin_user {
          name
          profile_image
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
        directories {
          id
          __typename
        }
        __typename
      }
      dental_practice {
        name
        logo
        directories {
          id
          __typename
        }
        __typename
      }
      dental_professional {
        name
        profile_image
        directories {
          id
          __typename
        }
        __typename
      }
      admin_user {
        name
        profile_image
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