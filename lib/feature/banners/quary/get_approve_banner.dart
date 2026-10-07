const String approveBannerQuary = r'''query GetBanners($status: String, $category_names: [String!], $banner_location: [String!], $schedule_date: timestamptz, $limit: Int, $offset: Int) {
  banners(
    where: {status: {_eq: $status}, category_name: {_in: $category_names}, banner_categories: {banner_location: {_has_keys_any: $banner_location}}, schedule_date: {_lt: $schedule_date}}
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    image
    url
    banner_categories {
      timer
      __typename
    }
    __typename
  }
}
''';

// category_name: { _eq: $category_name }
