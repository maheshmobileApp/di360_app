const String addBannerQuery = r''' 
 mutation InsertBannerCategory($banner: banners_insert_input!) {
    insert_banners(objects: [$banner]) {
      affected_rows
    }
  }
''';