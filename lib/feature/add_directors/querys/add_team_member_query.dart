const String TeamMemberQuery = r'''
mutation addTeam($ourTeamObj: directory_team_members_insert_input!) {
  insert_directory_team_members_one(object: $ourTeamObj) {
    id
    __typename
  }
}
''';

const String addGalleryQuery = r'''
mutation addGalleryImages($galleryObj: directory_gallery_posts_insert_input!) {
  insert_directory_gallery_posts_one(object: $galleryObj) {
    id
    __typename
  }
}
''';