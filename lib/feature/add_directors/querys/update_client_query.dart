String updateClientQuery =
    r'''mutation UpdateClient($id: uuid!, $changes: clients_set_input!) {
  update_clients_by_pk(pk_columns: {id: $id}, _set: $changes) {
    id
    __typename
  }
}''';
