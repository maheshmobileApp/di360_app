const String addBannerQuery = r''' 
 mutation insertRecord($fields: banners_insert_input!) {
  insert_banners_one(object: $fields) {
    id
    __typename
  }
}
''';

