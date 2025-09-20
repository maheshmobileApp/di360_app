const String getCourseRegisteredUsersQuery =
    r'''query getCourseRegisteredUsers($course_id: uuid!, $limit: Int!, $offset: Int!) {
    course_registered_users(
      where: { course_id: { _eq: $course_id } }
      limit: $limit
      offset: $offset
      order_by: { created_at: desc }
    ) {
      id
      first_name
      last_name
      email
      phone_number
      description
      course_id
      from_id
      created_at
    }
  }''';
