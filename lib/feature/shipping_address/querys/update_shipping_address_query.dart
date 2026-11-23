const String updateShippingAddressQuery =
    r'''mutation update_dental_professional_addresses_by_pk($id: uuid!, $dental_professional_addresses: dental_professional_addresses_set_input!) {
  update_dental_professional_addresses_by_pk(
    pk_columns: {id: $id}
    _set: $dental_professional_addresses
  ) {
    id
    __typename
  }
}''';
