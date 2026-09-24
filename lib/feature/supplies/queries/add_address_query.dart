const String addAddressQuery =
    r'''mutation addDentalProfessionalAddresses($dental_professional_addressees: dental_professional_addresses_insert_input!) {
  insert_dental_professional_addresses_one(
    object: $dental_professional_addressees
  ) {
    id
    __typename
  }
}''';
