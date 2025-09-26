const String editBannerViewQuary = r'''
query GetBannerById($id: uuid!) {
  banners_by_pk(id: $id) {
    status
    expiry_date
    image
    schedule_date
    banner_name
    url
    category_name
    created_at
    updated_at
    from_id
    id
    __typename
  }
}
''';