const String deleteProfessionalShippingAddressQuery =
    r'''mutation delete_dental_professional_addresses_by_pk($id: uuid!) {
  delete_dental_professional_addresses_by_pk(id: $id) {
    id
    __typename
  }
}''';
