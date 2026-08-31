const String practiceViewProfileQuery = r'''
query practiceDisplayV2($id: uuid!) {
  dental_practices_by_pk(id: $id) {
    id
    first_name
    last_name
    name
    email
    phone
    state
    professionType
    business_name
    business_email
    business_phone
    fax_number
    abn_number
    logo
    directory_business_type_id
    middle_name
    address
    address_line_one
    address_line_two
    city
    zipcode
    land_mark
    website_link
    directory_category_id
    profile_completed
    directories {
      id
      __typename
    }
    __typename
  }
}
''';
