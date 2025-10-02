const String updateBannerQuary = r'''
mutation UpdateBanner($id: uuid!, $data: banners_set_input!) {
  update_banners_by_pk(pk_columns: { id: $id }, _set: $data) {
		id
    views
  }
}
''';

