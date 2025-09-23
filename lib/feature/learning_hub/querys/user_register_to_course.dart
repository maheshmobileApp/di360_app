const String userRegisterToCourseQuery = r''' mutation registerUserToCourse(
  $object: course_registered_users_insert_input!
) {
  insert_course_registered_users_one(object: $object) {
    course_id
    first_name
    last_name
    phone_number
    email
    description
    
    # add any other columns you want returned
  }
}''';
