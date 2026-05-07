const String getMyRegisteredCourseQuery = r'''
query GetUserRegisteredCourses($where: courses_bool_exp!, $limit: Int!, $offset: Int!, $loginId: uuid) {
  courses(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {course_registered_users_aggregate: {max: {created_at: desc}}}
  ) {
    id
    type
    endDate
    startDate
    startTime
    endTime
    course_name
    description
    created_at
    cpd_points
    presenters
    presented_by_name
    presented_by_image
    company_name
    webinar_link
    afterwards_price
    cpd_points
    course_category_id
    course_category {
      id
      name
      __typename
    }
    course_registered_users(
      where: {from_id: {_eq: $loginId}}
      order_by: {created_at: desc}
      limit: 1
    ) {
      id
      webinar_status
      status
      first_name
      last_name
      from_id
      completed_date
      __typename
    }
    dental_supplier {
      logo
      __typename
    }
    __typename
  }
}
''';
