const String professionalViewProfileQuery = r'''query getProfDisplayV2($id: uuid!) {
  dental_professionals_by_pk(id: $id) {
    id
    first_name
    last_name
    name
    email
    phone
    state
    professionType
    aphra_registration_number
    profile_image
    directory_business_type_id
    middle_name
    gender
    date_of_birth
    salutation
    address
    address_line_one
    address_line_two
    city
    zipcode
    land_mark
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
