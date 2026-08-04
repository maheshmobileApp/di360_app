const String inactiveClientQuery = r'''
mutation updateClientStatus($id: uuid!, $updateObj: clients_set_input!) {
  update_clients_by_pk(pk_columns: {id: $id}, _set: $updateObj) {
    id
    __typename
  }
}
''';