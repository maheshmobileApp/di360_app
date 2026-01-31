const String getStatesByGroupsQuery =
    r'''query GetStatesByGroups($where: campaign_contacts_bool_exp!) {
  campaign_contacts(where: $where, distinct_on: state) {
    state
    __typename
  }
}''';
