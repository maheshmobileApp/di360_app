const String deleteCourseQuery =r'''
mutation DeleteCourse($id: uuid!) {
  delete_courses_by_pk(id: $id) {
    id
    __typename
}
}
''';
