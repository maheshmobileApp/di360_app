const String  getDirectorsQuery = r'''
query getDirectories {
  directories(order_by: {created_at: desc}) {
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