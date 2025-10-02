const String getCatalogueQuery = r'''
query getFilteredCatalogueData(
  $categoryWhere: catalogue_categories_bool_exp!
  $catalogueWhere: catalogues_bool_exp!
) {
  catalogue_categories(where: $categoryWhere) {
    id
    name
    catalogues(limit: 100, where: $catalogueWhere) {
      id
      title
      status
      thumbnail_image
      schedulerDay
      dental_supplier {
        name
        __typename
      }
      catalogue_sub_category {
        id
        name
        __typename
      }
      catalogue_favorites {
        catalogue_id
        type
        dental_supplier_id
        dental_practice_id
        dental_professional_id
        __typename
      }
      __typename
    }
    __typename
  }
}
''';
