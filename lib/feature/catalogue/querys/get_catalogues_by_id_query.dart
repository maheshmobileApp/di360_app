const String getCatalogueByIdRequest = r'''
query subscription_catalogues(
  $andList: [catalogues_bool_exp!],
  $limit: Int,
  $offset: Int,
  $loginId: uuid
) {
  catalogue_categories(
    where: {
      catalogues: {
        _and: [
          { catalogue_favorites: { dental_supplier_id: { _eq: $loginId } } },
          { _and: $andList }
        ]
      }
    }
  ) {
    id
    name
    catalogues(
      where: {
        _and: [
          { catalogue_favorites: { dental_supplier_id: { _eq: $loginId } } },
          { _and: $andList }
        ]
      }
      order_by: { updated_at: desc }
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
      catalogue_favorites(
        where: { dental_supplier_id: { _eq: $loginId } }
      ) {
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
