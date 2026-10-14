const String getDentalSuppliersQuery = r'''query dental_suppliers {
  dental_suppliers(where: {_not: {business_name: {_eq: "null"}}}) {
    id
    name
    logo
    business_name
    __typename
  }
}''';
