const String sendTalentMessageQuery =
    r'''mutation insert_message_one($object: talents_message_insert_input!) {
  insert_talents_message_one(object: $object) {
    id
    __typename
  }
}''';


