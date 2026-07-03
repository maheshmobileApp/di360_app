const String getUpdateCourseStatus =r'''
mutation UpdateCourseStatus($id: uuid!, $status: String!) {
  update_courses_by_pk(pk_columns: {id: $id}, _set: {active_status: $status}) {
    id
    active_status
    __typename
  }
}
''';

const String adminApproveTheCourseQuery = r'''
mutation updateRecord($id: uuid!, $fields: courses_set_input!) {
  update_courses_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';
