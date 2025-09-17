const String getCourseCategoryQuery = r'''
query course_categories($status: String, $search: String, $limit: Int, $offset: Int) { course_categories(order_by: {created_at: desc },where: {status: {_eq: $status}, name: {_ilike: $search}}, limit: $limit, offset: $offset) { id created_at 
  updated_at
  name
  status } }
''';
