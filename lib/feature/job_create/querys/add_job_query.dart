const String addJobQuery = r'''
mutation insert_jobpost($postjobObj: jobs_insert_input!) {
  insert_jobs_one(object: $postjobObj) {
    id
    __typename
  }
}
''';