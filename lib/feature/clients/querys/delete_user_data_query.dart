const String deleteUserDataQuery = r'''
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