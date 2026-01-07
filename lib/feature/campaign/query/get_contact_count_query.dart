const String getContactCountQuery =
    r'''query GetContactsCount($where: campaign_contacts_bool_exp!) {
  campaign_contacts_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
