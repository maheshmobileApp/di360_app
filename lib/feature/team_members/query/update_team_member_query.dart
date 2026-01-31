const String updateTeamMemberQuery =
    r'''mutation updateRecord($id: uuid!, $fields: clients_set_input!) {
  update_clients_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}''';
