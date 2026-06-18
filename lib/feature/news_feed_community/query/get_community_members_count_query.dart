const String getCommunityMembersCountQuery = r'''
query GetCommunityMembersCount($where: community_members_bool_exp) {
  community_members(where: $where, limit: 1) {
    dental_suppliers {
      business_name
      directories {
        id
        directory_partners {
          id
          __typename
        }
        directory_locations {
          id
          __typename
        }
        __typename
      }
      __typename
    }
    __typename
  }
  community_members_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';