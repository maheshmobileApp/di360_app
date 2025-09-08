const String updateJobProfileStatus = r'''
mutation UpdateTalentStatus($id: uuid!, $status: String!) {
  update_job_profiles_by_pk(pk_columns: {id: $id}, _set: {active_status: $status}) {
    id
    active_status
    __typename
  }
}
''';

