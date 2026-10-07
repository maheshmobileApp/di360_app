const String updateJobListingStatus= r'''
mutation updateRecord($id: uuid!, $fields: jobs_set_input!) {
  update_jobs_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';

