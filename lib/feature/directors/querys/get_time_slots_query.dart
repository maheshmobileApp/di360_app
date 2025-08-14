const String getTimeSlots = r'''
query ggetServices($id: uuid!) {
  directory_appointment_slots(where: {directory_id: {_eq: $id}}) {
    id
    directory_id
    service_name
    directory_service_id
    serviceMember
    day_wise_timeslots
    weekdays
    __typename
  }
}
''';
