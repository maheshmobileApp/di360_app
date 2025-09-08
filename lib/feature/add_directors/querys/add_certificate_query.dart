const String addCertificatesQuery = r'''
mutation addCertifications($certiObj: directory_certifications_insert_input!) {
  insert_directory_certifications_one(object: $certiObj) {
    id
    __typename
  }
}
''';

const String addAchievementsQuery = r'''
mutation addAchive($achObj: directory_achievements_insert_input!) {
  insert_directory_achievements_one(object: $achObj) {
    id
    __typename
  }
}
''';

const String addADocumentQuery = r'''
mutation addDocs($docsObj: directory_documents_insert_input!) {
  insert_directory_documents_one(object: $docsObj) {
    id
    __typename
  }
}
''';
