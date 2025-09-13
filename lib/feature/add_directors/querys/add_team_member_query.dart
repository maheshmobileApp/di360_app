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

const String updateOurTeamQuery = r'''
mutation updateTeam($id: uuid!, $ourTeamObj: directory_team_members_set_input!) {
  update_directory_team_members_by_pk(pk_columns: {id: $id}, _set: $ourTeamObj) {
    id
    __typename
  }
}
''';

const String deleteOurTeamQuery = r'''
mutation removeTeamMember($id: uuid!) {
  delete_directory_team_members(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String updateGalleryQuery = r'''
mutation updateImages($id: uuid!, $updateImagesObj: directory_gallery_posts_set_input!) {
  update_directory_gallery_posts(
    where: {directory_id: {_eq: $id}}
    _set: $updateImagesObj
  ) {
    affected_rows
    __typename
  }
}
''';

const String updateFAQQuery = r'''
mutation updateFaqs($id: uuid!, $faqsObj: directory_faqs_set_input!) {
  update_directory_faqs_by_pk(pk_columns: {id: $id}, _set: $faqsObj) {
    id
    __typename
  }
}
''';

const String deleteFAQQuery = r'''
mutation removeFaqs($id: uuid!) {
  delete_directory_faqs(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String updateTestimonialQuery = r'''
mutation updateTestimonials($id: uuid!, $updateTestimonials: directory_testimonials_set_input!) {
  update_directory_testimonials(
    where: {id: {_eq: $id}}
    _set: $updateTestimonials
  ) {
    affected_rows
    __typename
  }
}
''';

const String deleteTestimonialQuery = r'''
mutation removeTestimonial($id: uuid!) {
  delete_directory_testimonials(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';
