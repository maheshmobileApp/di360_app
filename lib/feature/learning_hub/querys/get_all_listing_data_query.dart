const String getAllListingDataQuery =
    r'''query getAllLearningHubList($limit: Int!, $offset: Int!, $where: courses_bool_exp!) {
  courses(
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
    where: {status: {_eq: "APPROVE"}, active_status: {_eq: "ACTIVE"}, _and: [$where]}
  ) {
    id
    course_name
    cpd_points
    created_by_id
    address
    company_name
    presenters
    max_subscribers
    endDate
    event_type
    startDate
    status
    created_at
    afterwards_price
    course_category_id
    active_status
    type
    course_banner_image
    number_of_seats
    startTime
    endTime
    course_registered_users {
      course_id
      from_id
      status
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
