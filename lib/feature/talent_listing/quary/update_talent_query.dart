const String updateTalentMessageQuery =
    r'''mutation UpdateTalentmessage($id: uuid!, $message: String!, $updated_at: timestamptz!) {
  update_talents_message_by_pk(
    pk_columns: {id: $id}
    _set: {message: $message, updated_at: $updated_at}
  ) {
    id
    message
    updated_at
    __typename
  }
}
''';
