const String getBusinessTypeQuery = r'''
query getBusinessTypes($type: String!) {
  directory_business_types(where: {type: {_eq: $type}}) {
    id
    type
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
