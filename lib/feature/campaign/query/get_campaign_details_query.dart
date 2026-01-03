const String getCampaignDetailsQuery = r'''query getRecordById($id: uuid!) {
  sms_campaign_by_pk(id: $id) {
    campaign_name
    schedule_date
    schedule_time_local
    schedule_timezone
    recipients_count
    mobile_email_count
    total_count
    message_text
    sms_segments_count
    characters_used
    is_repeating
    is_refined_by_state
    refine_state
    groups
    send_to_numbers
    status
    send_to_emails
    email_subject
    message_channel
    email_attachments
    from_email
    email_design_json
    __typename
  }
}''';
