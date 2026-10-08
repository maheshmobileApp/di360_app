const String getSupplierAccountsQuery =
    r'''query supplier_accounts($limit: Int, $offset: Int, $where: supplier_accounts_bool_exp) {
  supplier_accounts(
    where: $where
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    supplier_id
    account_number
    supplier {
      id
      name
      business_name
      __typename
    }
    __typename
  }
}''';
