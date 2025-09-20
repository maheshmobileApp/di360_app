const String getMyRegisteredCourseQuery = r'''
query getCoursesWithMyRegistrations( $limit: Int, $offset: Int, $from_id: uuid!) {
  courses(
    where: {
      _and: [
        { course_registered_users: { from_id: { _eq: $from_id } } }
      ]
    }
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
    cpd_points
    webinar_link
    company_name
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
