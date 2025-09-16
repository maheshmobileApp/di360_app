const String   getJobProfileRole= r''' 
query get_jobs_role_list {
  jobs_role_list(order_by: { created_at: desc }) {
    id
      role_name
      created_at
    }
  }

''';