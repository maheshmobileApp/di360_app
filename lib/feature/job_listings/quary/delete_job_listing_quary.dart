const String deleteJobListing = r'''
mutation DeleteJob($id: uuid!) {
  delete_jobs_by_pk(id: $id) {
    id
    __typename
  }
}''';