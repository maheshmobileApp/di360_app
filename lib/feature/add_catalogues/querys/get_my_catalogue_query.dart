const String getMyCatalogueQuery = r'''
query catalogues($limit: Int, $offset: Int, $where: catalogues_bool_exp!) {
  catalogues(order_by: {id: desc}, limit: $limit, offset: $offset, where: $where) {
    id
    title
    catalogue_status
    views
    status
    schedulerDay
    approved_at
    pending_at
    rejected_at
    repeat_months: months_count
    expiryDay
    created_at
    dental_supplier {
      name
      __typename
    }
    catalogue_category {
      id
      name
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
