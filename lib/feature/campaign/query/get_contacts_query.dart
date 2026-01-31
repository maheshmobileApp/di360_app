const String getContactsQuery =
    r'''query GetContacts($where: campaign_contacts_bool_exp!) {
  campaign_contacts(where: $where) {
    phone
    email
    __typename
  }
}''';
