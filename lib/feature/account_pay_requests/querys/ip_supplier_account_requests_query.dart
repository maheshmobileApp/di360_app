const String ipSupplierAccountRequestsQuery =
    r'''query supplier_account_requests($limit: Int, $offset: Int, $where: supplier_account_requests_bool_exp!) {
  supplier_account_requests(
    where: $where
    limit: $limit
    offset: $offset
    order_by: [{created_at: desc}, {id: desc}]
  ) {
    id
    created_at
    updated_at
    supplier_id
    dental_practice_id
    dental_professional_id
    dental_supplier_id
    name
    practice_name
    email
    phone
    abn_number
    billing_address
    notes
    status
    __typename
  }
}''';
