const String getDentalBusinessDetailsQuery =
    r'''query getRecordById($id: uuid!) {
  dental_suppliers_by_pk(id: $id) {
    first_name
    last_name
    business_name
    __typename
  }
}
''';
