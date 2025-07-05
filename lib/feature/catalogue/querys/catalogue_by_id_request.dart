const String catalogueByIdRequest = r'''
query getCatalogueById($id: uuid!) {
  catalogues_by_pk(id: $id) {
    id
    title
    dental_supplier_id
    attachment
    thumbnail_image
    views
    catalogue_category_id
    catalogue_category {
      id
      name
      __typename
    }
    __typename
  }
}
''';