const String getNotificationCampaignQuery =
    r'''query GetCourseNotificationCampaigns($where: course_notification_campaigns_bool_exp!, $limit: Int!, $offset: Int!, $order_by: [course_notification_campaigns_order_by!]) {
  course_notification_campaigns(
    where: $where
    order_by: $order_by
    limit: $limit
    offset: $offset
  ) {
    id
    campaign_name
    notification_channel
    email_subject
    recipient_mode
    send_mode
    scheduled_at
    total_recipients
    recipients_count
    status
    created_at
    notification_type
    __typename
  }
  course_notification_campaigns_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
