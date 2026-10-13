const String checkMailQuery = r'''query checkEmail($email: String!) {
  clients(where: {email: {_ilike: $email}}) {
    id
    email
    __typename
  }
}''';
