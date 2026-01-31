const String getCampaignListQuery =
    r'''query GetSmsCampaignList($limit: Int!, $offset: Int!, $where: sms_campaign_bool_exp!) {
  sms_campaign(
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
    where: $where
  ) {
    id
    campaign_name
    message_channel
    from_email
    message_text
    email_attachments
    schedule_date
    schedule_time_local
    is_repeating
    status
    created_at
    sent: sms_campaign_jobs_aggregate(where: {status: {_eq: "SENT"}}) {
      aggregate {
        count
        __typename
      }
      __typename
    }
    failed: sms_campaign_jobs_aggregate(where: {status: {_eq: "FAILED"}}) {
      aggregate {
        count
        __typename
      }
      __typename
    }
    queued: sms_campaign_jobs_aggregate(where: {status: {_eq: "PENDING"}}) {
      aggregate {
        count
        __typename
      }
      __typename
    }
    __typename
  }
  sms_campaign_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
