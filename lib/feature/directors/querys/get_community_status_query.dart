const String getCommunityStatusQuery =
    r'''query getCommunityStatus($member_id: uuid!, $community_id: uuid!) {
  community_members(
    where: {member_id: {_eq: $member_id}, community_id: {_eq: $community_id}}
    limit: 1
  ) {
    status
    __typename
  }
}''';

