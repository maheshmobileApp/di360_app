const String getCommentsQuery =
    r'''query Comments($feedId: uuid!, $limit: Int!, $offset: Int!) {
    news_feeds_comments(
      where: { news_feeds_id: { _eq: $feedId }, parent_comment_id: { _is_null: true } }
      order_by: { created_at: desc }
      limit: $limit
      offset: $offset
    ) {
      id
      comment_text
      created_at
      role_type
      attachments
      parent_comment_id

      replies_aggregate {
        aggregate {
          count
        }
      }
      created_by_id
      dental_professional { id name profile_image }
      dental_practice { id business_name logo }
      dental_supplier { id business_name logo }
      admin_user { id name profile_image }
    }
  }''';
