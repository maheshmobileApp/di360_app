const String approveBannerQuary = r'''
query getApprovedBanners($limit: Int, $offset: Int) {
  banners(
    where: { status: { _eq: "APPROVED" }}
    limit: $limit
    offset: $offset
  ) {
    id
    banner_name
    category_name
    status
    views
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
    }
  }
}
''';

// category_name: { _eq: $category_name }
