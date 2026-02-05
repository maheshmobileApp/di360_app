const String addContactQuery = r'''mutation insertRecord($fields: partners_contact_book_insert_input!) {
  insert_partners_contact_book_one(object: $fields) {
    id
    __typename
  }
}''';