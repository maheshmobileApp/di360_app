const String getBannersQuery = r'''
query getBannersDatas($where: banners_bool_exp, $limit: Int, $offset: Int) {
  banners(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
  ) {
    id
    status
    active_status
    image
    views
    banner_clicks
    banner_name
    company_name
    category_name
    created_at
    updated_at
    expiry_date
    schedule_date
    from_id
    dental_suppliers {
      id
      business_name
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
