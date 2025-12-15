const String addJobProfileQuery = r''' 
mutation createjob_profiles($jobProfile: [job_profiles_insert_input!] !) {
  insert_job_profiles(objects: $jobProfile){
    affected_rows
  }
}
''';