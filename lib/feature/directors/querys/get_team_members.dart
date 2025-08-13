const String team_members_querys = r'''
query getTeamMembers($id: uuid!) {
  directory_team_members(where: {directory_id: {_eq: $id}}) {
    id
    name
    specialization
    image
    phone
    email
    subrub
    state
    __typename
  }
}
''';