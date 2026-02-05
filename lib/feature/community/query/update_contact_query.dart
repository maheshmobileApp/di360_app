const String updateContactQuery =
    r'''mutation updateRecord($id: uuid!, $fields: partners_contact_book_set_input!) {
  update_partners_contact_book_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}''';
