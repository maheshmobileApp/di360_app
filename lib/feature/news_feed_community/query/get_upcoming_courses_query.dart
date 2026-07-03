String getUpcomingCoursesQuery =
    r'''query getMyCourseData($where: courses_bool_exp!, $limit: Int, $offset: Int) {
  courses(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {startDate: asc}
  ) {
    id
    course_name
    cpd_points
    address
    presenters
    startDate
    status
    type
    course_banner_image
    number_of_seats
    created_by_id
    community_id
    community_status
    community_user_type
    dental_supplier {
      business_name
      __typename
    }
    course_registered_users_aggregate(where: {status: {_neq: "CANCELLED"}}) {
      aggregate {
        count
        __typename
      }
      __typename
    }
    __typename
  }
}
''';
