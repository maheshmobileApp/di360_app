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

const String addFAQsQuery = r'''
mutation addFaqs($faqsObj: directory_faqs_insert_input!) {
  insert_directory_faqs_one(object: $faqsObj) {
    id
    __typename
  }
}
''';

const String addTestimonialsQuery = r'''
mutation addTeastmonials($testiObj: directory_testimonials_insert_input!) {
  insert_directory_testimonials_one(object: $testiObj) {
    id
    __typename
  }
}
''';

const String addLocationQuery = r'''
mutation addLocation($locationObj: directory_locations_insert_input!) {
  insert_directory_locations_one(object: $locationObj) {
    id
    __typename
  }
}
''';