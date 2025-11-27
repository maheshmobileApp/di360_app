const String getJoinRequestQuery =
    r'''query GetCommunityMembersByStatus($where: community_members_bool_exp!, $limit: Int!, $offset: Int!) {
  community_members(
    where: $where
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    first_name
    last_name
    membership_number
    status
    email
    phone
    supplier_id
    community_id
    register_link
    is_registered
    __typename
  }
}
''';
