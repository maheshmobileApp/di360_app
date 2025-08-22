const String getJobApplicantCountQuery = r'''
query getApplicantsStatusCounts($job_id: uuid!) {
  all: job_applicants_aggregate(
    where: { job_id: { _eq: $job_id } }
  ) {
    aggregate {
      count
    }
  }
  applied: job_applicants_aggregate(
    where: {
      status: { _eq: "APPLIED" }
      job_id: { _eq: $job_id }
    }
  ) {
    aggregate {
      count
    }
  }
  interviews: job_applicants_aggregate(
    where: {
      status: { _eq: "INTERVIEWS" }
      job_id: { _eq: $job_id }
    }
  ) {
    aggregate {
      count
    }
  }
  accepted: job_applicants_aggregate(
    where: {
      status: { _eq: "ACCEPTED" }
      job_id: { _eq: $job_id }
    }
  ) {
    aggregate {
      count
    }
  }
  rejected: job_applicants_aggregate(
    where: {
      status: { _eq: "REJECT" }
      job_id: { _eq: $job_id }
    }
  ) {
    aggregate {
      count
    }
  }
  shortlisted: job_applicants_aggregate(
    where: {
      status: { _eq: "SHORTLISTED" }
      job_id: { _eq: $job_id }
    }
  ) {
    aggregate {
      count
    }
  }  
}

''';