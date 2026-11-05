const String getPromotionDetailQuery = r'''query GetCoursePromotionDetail($id: uuid!) {
  course_promotions_by_pk(id: $id) {
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
    created_by_id
    created_by_role
    created_at
    updated_at
    __typename
  }
}''';