const String deletePracticeAccountQuery = r'''
mutation DeleteUserData($id: uuid!) {
  delete_clients(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
  delete_dental_practices(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
  delete_directories(where: {dental_professional_id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String deleteProfessionalAccountQuery = r'''
mutation DeleteUserData($id: uuid!) {
  delete_clients(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
  delete_dental_professionals(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
  delete_directories(where: {dental_professional_id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String deleteSupplierAccountQuery = r'''
mutation DeleteUserData($id: uuid!) {
  delete_clients(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
  delete_dental_suppliers(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
  delete_directories(where: {dental_professional_id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';
