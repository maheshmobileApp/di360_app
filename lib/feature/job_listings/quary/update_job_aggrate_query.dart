
const String updateJobApplicantStatusData = r'''
mutation UpdateJobApplicantStatus($id: uuid!, $status: String!) {
  update_job_applicants_by_pk(pk_columns: {id: $id}, _set: {status: $status}) {
    id
    status
    __typename
  }
}
''';
