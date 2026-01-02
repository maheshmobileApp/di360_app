const String updateRegUserStatusQuery =
    r'''mutation updateRecord($id: uuid!, $fields: course_registered_users_set_input!) {
  update_course_registered_users_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';
