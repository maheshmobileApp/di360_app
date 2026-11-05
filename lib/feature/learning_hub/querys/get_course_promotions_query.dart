const String getCoursePromotionsQuery =
    r'''query GetCoursePromotions($where: course_promotions_bool_exp!, $limit: Int!, $offset: Int!, $order_by: [course_promotions_order_by!]) {
  course_promotions(
    where: $where
    limit: $limit
    offset: $offset
    order_by: $order_by
  ) {
    id
    course_id
    promotion_name
    promo_code
    discount_type
    discount_value
    max_discount_amount
    eligible_user_type
    usage_limit
    used_count
    valid_from
    valid_until
    auto_apply
    status
    created_at
    updated_at
    __typename
  }
  course_promotions_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
