const String deleteCategoryQuery = r'''mutation deleteRecord($id: uuid!) {
  delete_newsfeed_categories_by_pk(id: $id) {
    id
    __typename
  }
}

''';
