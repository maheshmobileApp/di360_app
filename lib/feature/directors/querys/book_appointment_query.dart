const String bookAppointmentQuery = r'''
query getBookedSelService($id: [uuid!]!) {
  directory_appointments(where: {directory_service_id: {_in: $id}}) {
    id
    timeslot
    directory_service_id
    appointment_date
    __typename
  }
}
''';