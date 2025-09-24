const String deleteBannerQuery = r'''
mutation deleteBanner($id: uuid!) {
  delete_banners_by_pk(id: $id) {
    id
    __typename
  }
}
''';