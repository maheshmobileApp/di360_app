const String getCommunityMembersCountQuery = r'''
query GetCommunityMembersCount($supplierWhere: dental_suppliers_bool_exp, $memberWhere: community_members_bool_exp) {
  dental_suppliers(where: $supplierWhere, limit: 1) {
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
  community_members_aggregate(where: $memberWhere) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}
''';
