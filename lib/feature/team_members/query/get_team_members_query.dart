const String getTeamMembersQuery =
    r'''query getAccessRequests($where: clients_bool_exp!, $limit: Int!, $offset: Int!) {
  clients(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
  ) {
    id
    name
    email
    type
    status
    created_at
    sub_type
    supplier_access_id
    business_name
    name
    __typename
  }
  clients_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
