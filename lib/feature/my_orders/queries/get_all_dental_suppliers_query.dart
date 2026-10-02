const String getAllDentalSuppliersQuery = r'''
  query get_all_dental_suppliers {
  dental_suppliers {
    id
    name
    phone
    email
    profile_image
    business_name
    __typename
  }
}
''';