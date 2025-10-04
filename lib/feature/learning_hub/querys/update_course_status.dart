const String getUpdateCourseStatus =
    r'''mutation UpdateCourseStatus($id: uuid!, $status: String!) {
  update_courses_by_pk(pk_columns: {id: $id}, _set: {active_status: $status}) {
    id
    active_status
    __typename
  }
}''';
