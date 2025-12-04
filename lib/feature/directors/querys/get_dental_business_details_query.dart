const String getDentalBusinessDetailsSupplierQuery =
    r'''query getRecordById($id: uuid!) {
  dental_suppliers_by_pk(id: $id) {
    first_name
    last_name
    business_name
    __typename
  }
}
''';

const String getDentalBusinessDetailsProfessionalQuery =
    r'''query getRecordById($id: uuid!) {
  dental_professionals_by_pk(id: $id) {
    first_name
    last_name
    name
    __typename
  }
}

''';
