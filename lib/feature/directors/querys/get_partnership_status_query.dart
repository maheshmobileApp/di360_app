const String getPartnershipStatusQuery =
    r'''query getPartnershipStatus($member_id: uuid!, $community_id: uuid!) {
  partnership_members(
    where: {member_id: {_eq: $member_id}, community_id: {_eq: $community_id}}
    limit: 1
  ) {
    status
    type
    __typename
  }
}
''';
