const String getCatalogueRequest = r'''
query catalogues($andList: [catalogues_bool_exp!], $limit: Int, $offset: Int) {
  catalogue_categories(where: {catalogues: {_and: $andList}}) {
    id
    name
    catalogues(
      where: {_and: $andList}
      order_by: {updated_at: desc}
      limit: $limit
      offset: $offset
    ) {
      id
      title
      status
      thumbnail_image
      schedulerDay
      dental_supplier {
        directories {
          name
          __typename
        }
        __typename
      }
      catalogue_favorites {
        id
        catalogue_id
        type
        dental_supplier_id
        dental_professional_id
        dental_practice_id
        __typename
      }
      __typename
    }
    __typename
  }
}
''';
