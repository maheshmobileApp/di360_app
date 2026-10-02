const String accountPayRequestsViewQuery =
    r'''query supplier_account_requests($limit: Int, $offset: Int) {
  supplier_account_requests(
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    supplier_id
    name
    email
    phone
    abn_number
    billing_address
    notes
    status
    supplier {
      id
      name
      business_name
      __typename
    }
    __typename
  }
}''';
