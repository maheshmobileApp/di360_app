const String leaveCommunityQuery =
    r'''mutation DeleteByCondition($where: community_members_bool_exp!) {
  delete_community_members(where: $where) {
    affected_rows
    __typename
}
}''';
