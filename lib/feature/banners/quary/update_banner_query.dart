const String updateBannerQuary = r'''
mutation updateRecord($id: uuid!, $fields: banners_set_input!) {
  update_banners_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';

