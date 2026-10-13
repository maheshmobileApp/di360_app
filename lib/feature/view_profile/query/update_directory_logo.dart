const String updateDirectoryLogoQuery =
    r'''mutation update_directories_by_pk($id: uuid!, $dirObj: directories_set_input!) {
  update_directories_by_pk(pk_columns: {id: $id}, _set: $dirObj) {
    id
    __typename
  }
}''';
