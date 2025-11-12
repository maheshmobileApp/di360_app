const String updateMessageQuery =
    r'''mutation UpdateApplicantmessage($id: uuid!, $message: String!) {
  update_job_applicant_messages_by_pk(
    pk_columns: {id: $id}
    _set: {message: $message}
  ) {
    id
    message
    __typename
  }
}
''';
