const String addServicesQuery = r'''
mutation addServices($servicesObj: directory_services_insert_input!) {
  insert_directory_services_one(object: $servicesObj) {
    id
    __typename
  }
}
''';

const String updateServiceQuery = r'''
mutation updateService($id: uuid!, $servicesObj: directory_services_set_input!) {
  update_directory_services_by_pk(pk_columns: {id: $id}, _set: $servicesObj) {
    id
    __typename
  }
}
''';

const String deleteServiceQuery = r'''
mutation removeService($id: uuid!) {
  delete_directory_services(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';
