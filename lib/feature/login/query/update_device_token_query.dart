const String updateDeviceTokenQuery = r'''mutation updateDeviceToken(
  $id: uuid!
  $device_tokens: jsonb!
) {
  updateProfessional: update_dental_professionals(
    where: { id: { _eq: $id } }
    _append: { device_tokens: $device_tokens }
  ) {
    affected_rows
  }

  updateSupplier: update_dental_suppliers(
    where: { id: { _eq: $id } }
    _append: { device_tokens: $device_tokens }
  ) {
    affected_rows
  }

  updatePractice: update_dental_practices(
    where: { id: { _eq: $id } }
    _append: { device_tokens: $device_tokens }
  ) {
    affected_rows
  }
}
''';
