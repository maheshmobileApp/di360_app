const String dentalProfessionalAddressQuery =
    r'''query get_dental_professional_addresses {
  dental_professional_addresses {
    id
    city
    country
    created_at
    dental_professional_id
    google_place_id
    landmark
    latitude
    line_1
    line_2
    longitude
    make_default
    other_type_name
    postal_code
    short_name
    state
    type
    updated_at
    __typename
  }
}''';
