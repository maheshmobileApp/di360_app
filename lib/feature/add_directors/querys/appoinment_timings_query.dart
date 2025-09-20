const String updateTimingsQuery = r'''
mutation updateClinicTimes($id: uuid!, $locationObj: directory_locations_set_input!) {
  update_directory_locations_by_pk(pk_columns: {id: $id}, _set: $locationObj) {
    id
    __typename
  }
}
''';

const String deleteTimingsQuery = r'''
mutation removeLocations($id: uuid!) {
  delete_directory_locations(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String updateSocialQuery = r'''
mutation updateClinicTimes($id: uuid!, $locationObj: directory_locations_set_input!) {
  update_directory_locations_by_pk(pk_columns: {id: $id}, _set: $locationObj) {
    id
    __typename
  }
}
''';

const String addAppointmentQuery = r'''
mutation addAppt($apptData: directory_appointment_slots_insert_input!) {
  insert_directory_appointment_slots_one(object: $apptData) {
    id
    __typename
  }
}
''';

const String deleteAppointmentQuery = r'''
mutation removeAppt($id: uuid!) {
  delete_directory_appointment_slots(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String getApptsQuery = r'''
query getAppts($id: uuid!) {
  directory_appointment_slots(where: {directory_id: {_eq: $id}}) {
    id
    day_wise_timeslots
    serviceMember
    service_name
    duration_in_minites
    directory_service_id
    weekdays
    __typename
  }
}
''';
