const String getCourseRegisteredUsersQuery =
    r'''query getCourseRegisteredUsers($limit: Int!, $offset: Int!, $where: course_registered_users_bool_exp) {
  course_registered_users(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {created_at: desc}
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
    webinar_status
    status
    directories_practice {
      id
      dental_practice {
        id
        logo
        __typename
      }
      __typename
    }
    directories_supplier {
      id
      dental_supplier {
        id
        logo
        __typename
      }
      __typename
    }
    directories_professional {
      id
      dental_professional {
        id
        profile_image
        __typename
      }
      __typename
    }
    __typename
  }
}
''';
