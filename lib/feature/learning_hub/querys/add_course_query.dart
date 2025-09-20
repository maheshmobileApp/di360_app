const String addCourseQuery = r'''
mutation InsertCourse($object: courses_insert_input!) {
    insert_courses_one(object: $object) {
      id
    }
  }

''';
