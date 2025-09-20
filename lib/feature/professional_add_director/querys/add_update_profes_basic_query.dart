const String updateBasicInfoQuery = r'''
mutation updateBasicInfoProf($id: uuid!, $professinalUpdateObj: directories_set_input!) {
  update_directories(where: {id: {_eq: $id}}, _set: $professinalUpdateObj) {
    affected_rows
    __typename
  }
}
''';

const String addProfessBasicInfoQuery = r'''
mutation addDirectory($professinalObj: directories_insert_input!) {
  insert_directories_one(object: $professinalObj) {
    id
    __typename
  }
}
''';