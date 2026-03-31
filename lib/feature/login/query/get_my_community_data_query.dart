const String getMyCommunityDataQuery = r'''
query getMyCommunityData($where: community_members_bool_exp!) {
  community_members(where: $where) {
    id
    community_name
    community_id
    __typename
  }
}
''';
