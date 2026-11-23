const String addShippingAddressQuery =
    r'''mutation addDentalProfessionalAddresses($dental_professional_addressees: dental_professional_addresses_insert_input!) {
  insert_dental_professional_addresses_one(
    object: $dental_professional_addressees
  ) {
    id
    __typename
  }
}''';

const String addShippingAddressPracticeQuery = r'''mutation addDentalPracticeAddresses($dental_practice_addressees: dental_practice_addresses_insert_input!) {
  insert_dental_practice_addresses_one(object: $dental_practice_addressees) {
    id
    __typename
  }
}''';
