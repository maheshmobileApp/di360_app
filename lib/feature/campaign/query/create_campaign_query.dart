const String createCampaignQuery =
    r'''mutation insertRecord($fields: sms_campaign_insert_input!) {
  insert_sms_campaign_one(object: $fields) {
    id
    __typename
  }
}''';
