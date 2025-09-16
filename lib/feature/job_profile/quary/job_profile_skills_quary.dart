const String   getJobProfileSkills= r'''  
query getSkills {
  job_skills(order_by: { created_at: desc }) {
    id
      name
      created_at
    }
  }

''';