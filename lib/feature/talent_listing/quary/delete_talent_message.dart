const String deleteTalentMessageQuery =
    r'''mutation DeleteTalentMessage($id: uuid!, $deleted_status: Boolean!) {
  update_talents_message_by_pk(
    pk_columns: {id: $id}
    _set: {deleted_status: $deleted_status}
  ) {
    id
    deleted_status
    __typename
  }
}
''';
