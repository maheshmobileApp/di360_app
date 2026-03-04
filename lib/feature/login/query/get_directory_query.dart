const String getDirectorQuery = r'''
query getDirectory($id: uuid!) {
  directories(
    where: {_or: [{dental_practice_id: {_eq: $id}}, {dental_professional_id: {_eq: $id}}, {dental_supplier_id: {_eq: $id}}]}
  ) {
    directory_category_id
    id
    __typename
  }
}
''';
