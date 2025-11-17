const String deleteMessageQuery =
    r'''mutation DeleteapplicantMessage($id: uuid!, $deleted_status: Boolean!) {
  update_job_applicant_messages_by_pk(
    pk_columns: {id: $id}
    _set: {deleted_status: $deleted_status}
  ) {
    id
    deleted_status
    __typename
  }
}''';
