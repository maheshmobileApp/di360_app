const String updateJobListingStatus= r'''
mutation UpdateJobStatus($id: uuid!, $status: String!) {
  update_jobs_by_pk(pk_columns: {id: $id}, _set: {active_status: $status}) {
    id
    active_status
    __typename
  }
}''';

