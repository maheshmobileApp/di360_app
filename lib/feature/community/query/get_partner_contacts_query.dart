const String getPartnerContactsQuery =
    r'''query getPartnersContact($where: partners_contact_book_bool_exp!, $limit: Int!, $offset: Int!) {
  partners_contact_book(
    where: $where
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    contact_name
    email
    phone
    company_name
    state
    created_at
    created_by_id
    contact_type
    __typename
  }
  partners_contact_book_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
