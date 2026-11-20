const String notificationCampaignDetailQuery =
    r'''query GetCourseNotificationCampaignDetail($id: uuid!) {
  course_notification_campaigns_by_pk(id: $id) {
    id
    course_id
    campaign_name
    notification_channel
    notification_type
    template_type
    email_subject
    message_body
    attachments
    recipient_mode
    custom_recipient
    recipient_status_filter
    send_mode
    scheduled_at
    total_recipients
    recipients_count
    status
    reply_to_email
    created_at
    __typename
  }
}''';
