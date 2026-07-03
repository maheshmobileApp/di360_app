const String getCatalougesForAllTabQuery = r'''query getCataloguesForAllTab($where: catalogues_bool_exp!, $limit: Int!, $offset: Int!) {
  catalogues(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
  ) {
    id
    title
    thumbnail_image
    dental_supplier_id
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
    dental_supplier {
      name
      business_name
      __typename
    }
    catalogue_sub_category {
      id
      name
      __typename
    }
    __typename
  }
}
''';