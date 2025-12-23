const String updateTalentListingQuery =
    r'''mutation UpdateTalentStatus($id: uuid!, $status: String!) {
  update_jobhirings_by_pk(pk_columns: {id: $id}, _set: {hiring_status: $status}) {
    id
    hiring_status
    __typename
  }
}
''';
