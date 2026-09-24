const String filterSuppilerQuery = r'''
query getAllCatalogueSupplierName {
  catalogues(
    distinct_on: dental_supplier_id
    order_by: [{dental_supplier_id: asc}, {created_at: desc}]
    where: {status: {_in: ["APPROVED", "SCHEDULED"]}, catalogue_status: {_eq: "ACTIVE"}}
  ) {
    dental_supplier {
      id
      business_name
      community_id
      __typename
    }
    __typename
  }
}
''';