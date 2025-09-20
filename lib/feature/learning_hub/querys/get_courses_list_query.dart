const String getCoursesQuery = r'''
query ShowCourses($where: courses_bool_exp, $limit: Int, $offset: Int) { courses(where: $where, limit: $limit, offset: $offset, order_by: { created_at: desc }) { id created_at
  course_name 
  type 
  startDate endDate
  presented_by_image
  presented_by_name 
  description 
  company_name 
  status 
  active_status 
  created_by_id 
  course_registered_users_aggregate { aggregate { count } } } }
''';
