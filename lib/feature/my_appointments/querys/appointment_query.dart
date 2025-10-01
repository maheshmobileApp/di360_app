const String getAppointmentsQuery = r'''
query getUeserPracDirectory($id: uuid!) {
  directories(where: {dental_supplier_id: {_eq: $id}}) {
    directory_appointments {
    id
    directory_id
    directory_service_id
    appointment_date
    service_name
    name
    email
    phone
    status
    timeslot
    __typename
    }
  }
}
''';