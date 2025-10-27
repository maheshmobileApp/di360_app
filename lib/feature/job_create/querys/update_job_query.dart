const String updateJobQuery =
    r'''mutation update_jobpost($id: uuid!, $postjobObj: jobs_set_input!) {
  update_jobs_by_pk(pk_columns: {id: $id}, _set: $postjobObj) {
    id
    __typename
  }
}''';
