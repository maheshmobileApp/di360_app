const String GetDirectorBasedOnCatagoryQuery = r'''
query getDirectories($andList: [directories_bool_exp!]) {
  directories(
    where: { _and: $andList }
    order_by: { created_at: desc }
  ) {
    id
    name
    company_name
    logo
    profile_image
    address
    pincode
    __typename
  }
}
''';