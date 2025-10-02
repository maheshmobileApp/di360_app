const String updateCourseQuery = r'''
mutation UpdateCourse($id: uuid!, $changes: courses_set_input!) {
    update_courses_by_pk(pk_columns: { id: $id }, _set: $changes) {
  id
}
}
''';
