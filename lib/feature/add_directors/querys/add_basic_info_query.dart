const String addBasicInfoQuery = r'''
mutation addDirectory($dirObj: directories_insert_input!) {
  insert_directories_one(object: $dirObj) {
    id
    __typename
  }
}
''';

const String updateBasicInfoQuery = r'''
mutation updateBasicInfo($id: uuid!, $updateInfo: directories_set_input!) {
  update_directories(where: {id: {_eq: $id}}, _set: $updateInfo) {
    affected_rows
    __typename
  }
}
''';