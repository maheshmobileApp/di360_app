const String GetTalentStatusCountsQuery = r'''
query GetTalentStatusCounts {
  all: job_profiles_aggregate {
    aggregate {
      count
    }
  }
  approved: job_profiles_aggregate(
    where: { admin_status: { _eq: "APPROVED" } }
  ) {
    aggregate {
      count
    }
  }
  pending: job_profiles_aggregate(
    where: { admin_status: { _eq: "PENDING" } }
  ) {
    aggregate {
      count
    }
  }
  rejected: job_profiles_aggregate(
    where: { admin_status: { _eq: "REJECTED" } }
  ) {
    aggregate {
      count
    }
  }
  enquiry: job_profiles_aggregate(
    where: { admin_status: { _eq: "ENQUIRY" } }
  ) {
    aggregate {
      count
    }
  }
  cancelled: job_profiles_aggregate(
    where: { admin_status: { _eq: "CANCELLED" } }
  ) {
    aggregate {
      count
  }
   }
}
  ''';

