const String showCourseById = r'''query ShowCourseById($id: uuid!) {
  courses(where: { id: { _eq: $id } }) {
    id
    course_category_id
    short_id
    course_name
    short_info
    image
    video
    complete_details
    attachments
    is_featured
    active_status
    type
    address
    scheduled_at
    max_subscribers
    price_in_aud
    price_in_usd
    seo_metadata
    webinar_link
    presented_by_image
    presented_by_name
    description
    course_event_info
    early_bird_end_date
    topics_included
    learning_objectives
    event_type
    created_by_id
    company_name
    status
    sponsor_by_image
    terms
    refund_policy
    contact_name
    contact_email
    contact_phone
    contact_website
    cpd_points
    number_of_seats
    early_bird_price
    afterwards_price
    course_gallery
    course_banner_video
    course_banner_image
    register_link
    meeting_link
    feed_type
    active_status_feed
    user_role
    rsvp_date
    startDate
    endDate
    startTime
    endTime
    created_at
    updated_at

    # Aggregate for registered users
    course_registered_users_aggregate {
      aggregate {
        count
      }
    }
  }
}''';
