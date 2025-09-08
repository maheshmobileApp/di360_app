const String TeamMemberQuery = r'''
mutation addTeam($ourTeamObj: directory_team_members_insert_input!) {
  insert_directory_team_members_one(object: $ourTeamObj) {
    id
    __typename
  }
}
''';