const String getMyCatalogueQuery = r'''
query catalogues($limit: Int, $offset: Int, $searchTitle: String, $searchCategory: String, $searchCompany: String, $status: [String!], $dental_supplier_id: uuid, $startDate: timestamp, $endDate: timestamp) {
  catalogues(
    order_by: {id: desc}
    limit: $limit
    offset: $offset
    where: {_and: [{status: {_in: $status}, dental_supplier_id: {_eq: $dental_supplier_id}}, {_or: [{title: {_ilike: $searchTitle}}, {catalogue_category: {name: {_ilike: $searchCategory}}}, {dental_supplier: {name: {_ilike: $searchCompany}}}]}]}
  ) {
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
    __typename
  }
}
''';
