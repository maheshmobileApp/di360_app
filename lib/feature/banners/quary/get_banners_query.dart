const String getBannersQuery = r'''
query getBannersDatas($where: banners_bool_exp, $limit: Int, $offset: Int) {
  banners(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
  ) {
    status
    expiry_date
    image
    schedule_date
    banner_name
    category_name
    company_name
    created_at
    updated_at
    from_id
    id
    views
    dental_suppliers {
      id
      name
      type
      __typename
    }
    __typename
  }
  banners_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';
