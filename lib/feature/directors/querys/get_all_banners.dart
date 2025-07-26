const String getAllBannersQuery = r'''
query GetAllBannerData($status: String, $category_names: [String!], $banner_location: [String!]) {
  banners(
    where: {status: {_eq: $status}, category_name: {_in: $category_names}, banner_categories: {banner_location: {_has_keys_any: $banner_location}}}
    order_by: {created_at: desc}
  ) {
    id
    banner_name
    category_name
    status
    expiry_date
    image
    schedule_date
    created_at
    updated_at
    from_id
    views
    url
    company_name
    dental_suppliers {
      name
      __typename
    }
    banner_categories {
      id
      name
      banner_location
      timer
      __typename
    }
    __typename
  }
}
''';