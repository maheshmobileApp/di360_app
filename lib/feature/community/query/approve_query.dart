const String approveQuery =
    r'''mutation updateRecord($id: uuid!, $fields: community_members_set_input!) {
  update_community_members_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';

