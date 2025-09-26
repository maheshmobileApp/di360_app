const String getMyRegisteredCourseQuery = r'''
query getCoursesWithMyRegistrations(
  $limit: Int
  $offset: Int
  $where: courses_bool_exp
) {
  courses(
    where: $where
    limit: $limit
    offset: $offset
    order_by: { created_at: desc }
  ) {
    id
    course_name
    type
    startDate
    endDate
    presented_by_name
    presented_by_image
    company_name
    cpd_points
    status
    active_status
    created_at
    course_registered_users_aggregate {
      aggregate {
        count
      }
    }
  }
}''';
