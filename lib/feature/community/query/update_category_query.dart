const String updateCategoryQuery =
    r'''mutation updateRecord($id: uuid!, $fields: newsfeed_categories_set_input!) {
  update_newsfeed_categories_by_pk(pk_columns: {id: $id}, _set: $fields) {
    id
    __typename
  }
}
''';
