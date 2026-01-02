const String deleteCampaignQuery = r'''mutation deleteRecord($id: uuid!) {
  delete_sms_campaign_by_pk(id: $id) {
    id
    __typename
  }
}''';
