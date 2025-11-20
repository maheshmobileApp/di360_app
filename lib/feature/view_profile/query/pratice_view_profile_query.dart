const String practiceViewProfileQuery = r'''
query practiceDisplay($id: uuid!) {
  dental_practices_by_pk(id: $id) {
    id
    email
    name
    logo
    phone
    address
    pro_details_aphra_registration_number
    bank_details
    business_name
    abn_number
    business_email
    business_phone
    fax_number
    alt_email
    alt_phone
    profession_type
    tga_number
    second_hand
    sell_products
    first_name
    middle_name
    last_name
    type
    secondary_contact
    __typename
  }
}
''';
