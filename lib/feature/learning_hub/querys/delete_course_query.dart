const String deleteCourseQuery =
    r'''mutation deleteRegisteredCourse($id: uuid!) {
  delete_course_registered_users_by_pk(id: $id) {
    id

  }
}''';
