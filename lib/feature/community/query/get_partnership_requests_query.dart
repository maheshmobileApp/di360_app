const String getPartnershipRequestsQuery =
    r'''query GetPartnershipMembersByStatus($where: partnership_members_bool_exp!, $limit: Int!, $offset: Int!) {
  partnership_members(
    where: $where
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    company_name
    contact_name
    email
    phone
    status
    is_registered
    community_id
    supplier_id
    register_link
    __typename
  }
}
''';
