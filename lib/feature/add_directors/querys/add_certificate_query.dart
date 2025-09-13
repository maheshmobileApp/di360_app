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

const String updateCertificateQuery = r'''
mutation updateCertifications($id: uuid!, $updateCerti: directory_certifications_set_input!) {
  update_directory_certifications(where: {id: {_eq: $id}}, _set: $updateCerti) {
    affected_rows
    __typename
  }
}
''';

const String deleteCertificateQuery = r'''
mutation removeCertification($id: uuid!) {
  delete_directory_certifications(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String updateAchievementQuery = r'''
mutation updateAchive($id: uuid!, $updateAch: directory_achievements_set_input!) {
  update_directory_achievements(where: {id: {_eq: $id}}, _set: $updateAch) {
    affected_rows
    __typename
  }
}
''';

const String deleteAchieveQuery = r'''
mutation removeAchivements($id: uuid!) {
  delete_directory_achievements(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String updateDocumentQuery = r'''
mutation updateBasicInfo($id: uuid!, $updateDocs: directory_documents_set_input!) {
  update_directory_documents(where: {id: {_eq: $id}}, _set: $updateDocs) {
    affected_rows
    __typename
  }
}
''';

const String deleteDocumentQuery = r'''
mutation removeDocument($id: uuid!) {
  delete_directory_documents(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';
