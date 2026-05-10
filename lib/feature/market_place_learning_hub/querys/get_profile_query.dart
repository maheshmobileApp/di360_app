const String getSupplierProfile = r'''
query getSupplier($id: uuid!) {
  dental_suppliers_by_pk(id: $id) {
    id
    logo
    email
    first_name
    last_name
    phone
    name
    __typename
  }
}
''';

const String getProfessionalProfile = r'''
query getProfessional($id: uuid!) {
  dental_professionals_by_pk(id: $id) {
    id
    email
    name
    phone
    first_name
    last_name
    profile_image
    __typename
  }
}
''';

const String getPracticeProfile = r'''
query getPractice($id: uuid!) {
  dental_practices_by_pk(id: $id) {
    id
    email
    name
    phone
    first_name
    last_name
    profile_image
    __typename
  }
}
''';