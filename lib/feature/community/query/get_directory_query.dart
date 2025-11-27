const String getDirectoryQuery =
    r'''query getDirectory($where: directories_bool_exp!) {
  directories(where: $where) {
    id
    dental_supplier_id
    community_id
    partnership_link
    membership_link
    community_status
    __typename
  }
}
''';
