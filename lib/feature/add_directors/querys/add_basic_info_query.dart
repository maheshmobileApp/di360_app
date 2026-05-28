const String addBasicInfoQuery = r'''
mutation addDirectory($dirObj: directories_insert_input!) {
  insert_directories_one(object: $dirObj) {
    id
    __typename
  }
}
''';

const String updateBasicInfoQuery = r'''
mutation updateRecord($id: uuid!, $changes: directories_set_input!) {
  update_directories_by_pk(pk_columns: {id: $id}, _set: $changes) {
    id
    description
    __typename
  }
}
''';


