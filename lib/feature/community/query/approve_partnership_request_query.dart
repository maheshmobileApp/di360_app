const String approvePartnershipQuery =
    r'''mutation updateRecord($id: uuid!, $fields: partnership_members_set_input!) {
  update_partnership_members_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';
