const String GetDirectorBasedOnCatagoryQuery = r'''
query getDirectories($id: uuid!) {
  directories(
    where: {directory_category_id: {_eq: $id}}
    order_by: {created_at: desc}
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