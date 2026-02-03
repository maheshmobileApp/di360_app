const String updateJobProfileQuery = r''' 
mutation update_job_profiles($id: uuid!, $postjobObj: job_profiles_set_input!) {
  update_job_profiles_by_pk(pk_columns: {id: $id}, _set: $postjobObj) {
    id
    __typename
  }
}
''';