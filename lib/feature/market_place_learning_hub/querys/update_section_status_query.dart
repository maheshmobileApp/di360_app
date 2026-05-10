const String updatedTheCourseCompletedStatusQuery = r'''  
mutation insertRecord($fields: registered_course_module_insert_input!) {
  insert_registered_course_module_one(object: $fields) {
    id
    __typename
  }
}
''';
