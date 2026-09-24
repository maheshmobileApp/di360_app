const String getTeamMembersQuery =
    r'''query getAccessRequests($where: supplier_access_bool_exp!, $limit: Int!, $offset: Int!) {
  supplier_access(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
  ) {
    id
    name
    phone
    created_at
    clients {
      email
      type
      status
      __typename
    }
    __typename
  }
  supplier_access_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
