const String getShippingAddressesProfessionalQuery =
    r'''query dental_professional_addresses($search: String, $status: String, $limit: Int, $offset: Int) {
  dental_professional_addresses(
    where: {short_name: {_ilike: $search}}
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    dental_professional_id
    email
    short_name
    line_1
    line_2
    landmark
    city
    state
    country
    postal_code
    latitude
    longitude
    google_place_id
    make_default
    type
    other_type_name
    __typename
  }
}''';
