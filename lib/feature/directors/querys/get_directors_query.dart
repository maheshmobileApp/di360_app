const String  getDirectorsQuery = r'''
query getDirectories($limit: Int, $offset: Int, $where: directories_bool_exp) {
  directories(
    where: $where
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    name
    company_name
    logo
    type
    business_name
    profile_image
    address
    pincode
    status
    __typename
  }
}
''';