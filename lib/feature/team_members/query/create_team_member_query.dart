const String createTeamMemberQuery =
    r'''mutation signUp($signUpObj: clients_insert_input!) {
  insert_clients_one(object: $signUpObj) {
    id
    email
    phone
    client_verification_key
    type
    __typename
  }
}''';
