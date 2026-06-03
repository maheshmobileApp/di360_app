const String getJoinedCommunityQuery =
    r'''query getJoinedCommunities($member_id: uuid!) {
  community_members(
    where: {member_id: {_eq: $member_id}, status: {_eq: "APPROVED"}}
  ) {
    id
    community_id
    community_name
    dental_suppliers {
      business_name
      __typename
    }
    supplier_id
    member_id
    status
    __typename
  }
}
''';
