const String getMarketPlaceCoursesQuery =
    r'''query getAllLearningHubList($limit: Int!, $offset: Int!, $where: courses_bool_exp!) {
  courses(
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
    where: {status: {_eq: "APPROVE"}, active_status: {_eq: "ACTIVE"}, _and: [$where]}
  ) {
    id
    presented_by_name
    course_name
    cpd_points
    address
    company_name
    presented_by_image
    max_subscribers
    endDate
    event_type
    startDate
    status
    created_at
    course_category_id
    active_status
    type
    course_banner_image
    number_of_seats
    startTime
    endTime
    course_registered_users_aggregate {
      aggregate {
        count
        __typename
      }
      __typename
    }
    __typename
  }
}''';
