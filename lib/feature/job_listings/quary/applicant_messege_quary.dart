const String  applicantMessge = r''' 
mutation insert_message_one($object: job_applicant_messages_insert_input!) {
  insert_job_applicant_messages_one(object: $object) {
    id
  }
}

 ''';

 const String  talentMessge = r''' 
mutation insert_message_one($object: talents_message_insert_input!) {
  insert_talents_message_one(object: $object) {
    id
    __typename
  }
}
 ''';