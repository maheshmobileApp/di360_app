const String addServicesQuery = r'''
mutation addServices($servicesObj: directory_services_insert_input!) {
  insert_directory_services_one(object: $servicesObj) {
    id
    __typename
  }
}
''';