const String getSubSupplierQuery = r'''query getSubSupplierById($id: uuid!) {
  clients_by_pk(id: $id) {
    id
    business_name
    email
    phone
    password
    permissions
    name
    __typename
  }
}''';
