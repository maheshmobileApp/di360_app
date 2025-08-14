const String bookAppointmentQuery = r'''
mutation addApptToDash($apptData: directory_appointments_insert_input!) {
  insert_directory_appointments_one(object: $apptData) {
    id
    __typename
  }
}
''';
