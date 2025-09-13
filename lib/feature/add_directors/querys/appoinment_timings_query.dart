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
