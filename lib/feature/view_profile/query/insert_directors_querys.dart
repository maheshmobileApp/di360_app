const String professionalInsertDirectory = r'''
mutation InsertDirectory($object: directories_insert_input!) {
  insert_directories_one(object: $object) {
    id
    name
    email
    phone
    address
    profession_type
    type
    dental_professional_id
    profile_image
    phone_visibility
    email_visibility
  }
}
''';

const String supplierInsertDirectory = r'''
mutation InsertDirectory(
  $object: directories_insert_input!
) {
  insert_directories_one(object: $object) {
    id
    name
    email
    phone
    mobile_number
    business_name
    business_email
    profession_type
    abn_acn
    address
    type
    dental_supplier_id
    logo
    __typename
  }
}
''';

const String practiceInsertDirectory = r'''
mutation InsertDirectory(
  $object: directories_insert_input!
) {
  insert_directories_one(object: $object) {
    id
    name
    email
    phone
    mobile_number
    business_name
    business_email
    profession_type
    abn_acn
    address
    type
    dental_practice_id
    logo
    __typename
  }
}
''';
