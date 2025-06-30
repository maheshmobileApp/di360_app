String getRelatedCatalogQuery = r'''
query getRelatedTags($id: uuid!) {
  catalogues(
    where: {catalogue_category_id: {_eq: $id}, status: {_eq: "APPROVED"}, catalogue_status: {_eq: "ACTIVE"}}
  ) {
    id
    title
    dental_supplier_id
    thumbnail_image
    catalogue_favorites {
      id
      catalogue_id
      type
      dental_supplier_id
      dental_professional_id
      dental_practice_id
      __typename
    }
    catalogue_category {
      id
      name
      __typename
    }
    __typename
  }
}
''';