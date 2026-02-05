const String deleteContactQuery = r'''mutation deleteRecord($id: uuid!) {
  delete_partners_contact_book_by_pk(id: $id) {
    id
    __typename
  }
}''';
