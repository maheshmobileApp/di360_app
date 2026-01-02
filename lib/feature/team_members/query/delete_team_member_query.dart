const String deleteTeamMemberQuery = r'''mutation deleteRecord($id: uuid!) {
  delete_clients_by_pk(id: $id) {
    id
    __typename
  }
}''';
