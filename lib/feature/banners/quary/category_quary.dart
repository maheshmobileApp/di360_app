const String bannersCategoryQuery = r'''
 query getBannersCategory {
    banner_categories {
      id
      name
      dimensions
      banner_location
      timer
      created_at
      updated_at
      status

    }
  } ''';
