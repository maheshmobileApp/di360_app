const String deleteJobProfile = r'''
mutation DeleteJobHiringsByProfessionalId($dental_professional_id: uuid!) {
  delete_jobhirings(
    where: { dental_professional_id: { _eq: $dental_professional_id } }
  ) {
    affected_rows
  }
}

''';

