const String userRegisterToCourseQuery = r'''
mutation insertRecord($fields: course_registered_users_insert_input!) {
  insert_course_registered_users_one(object: $fields) {
    id
    __typename
  }
}
''';
