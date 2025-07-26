const String catalogueViewQuery = r'''
query getCatalogueById($id: uuid!) {
  catalogues_by_pk(id: $id) {
    id
    title
    dental_supplier_id
    attachment
    months_count
    schedulerDay
    thumbnail_image
    views
    status
    reject_reason
    catalogue_category {
      id
      name
      __typename
    }
    __typename
  }
}
''';
