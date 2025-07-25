const String directoriesCatagoryQuery = r'''
query getDirBusinessTypes {
  directory_business_types {
    id
    name
    directory_categories {
      id
      name
      __typename
    }
    __typename
  }
}
''';
