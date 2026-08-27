const String directoryInsertRecordQuery =
    r'''mutation insertRecord($object: directories_insert_input!) {
  insert_directories_one(object: $object) {
    id
    name
    email
    phone
    __typename
  }
}
''';
