const String getCoursesQuery = r'''
query ShowCourses($where: courses_bool_exp, $limit: Int, $offset: Int) {
  courses(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
  ) {
    id
    created_at
    course_name
    course_category_id
    contact_name
    type
    startDate
    endDate
    startTime
    endTime
    presenters
    description
    address
    cpd_points
    number_of_seats
    early_bird_end_date
    early_bird_price
    afterwards_price
    topics_included
    learning_objectives
    event_type
    course_event_info
    sponsor_by_image
    course_banner_video
    course_banner_image
    course_gallery
    terms
    refund_policy
    company_name
    contact_website
    status
    active_status
    register_link
    rsvp_date
    webinar_link
    created_by_id
    module_details {
      id
      section_details {
        id
        __typename
      }
      __typename
    }
    quiz_details {
      id
      option_details {
        id
        __typename
      }
      __typename
    }
    course_registered_users_aggregate {
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
