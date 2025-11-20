const String professionalViewProfileQuery = r'''
query professionalDisplay($id: uuid!) {
  dental_professionals_by_pk(id: $id) {
    id
    email
    name
    phone
    first_name
    middle_name
    last_name
    second_hand
    alt_email
    alt_phone
    profession_type
    address
    pro_details_aphra_registration_number
    bank_details
    date_of_birth
    salutation
    driving_licence
    profile_image
    gender
    type
    clients {
      state
      postal_code
      __typename
    }
    directories {
      id
      name
      email
      phone
      profile_image
      address
      profession_type
      __typename
    }
    __typename
  }
}
''';
