const String getTalentHiringCountByStatusQuery = r'''
query getTalentEnquiryCounts($where: talent_enquiries_bool_exp!) {
  talent_enquiries(where: $where) {
    id
    job_profiles {
      admin_status
    }
  }

  total: talent_enquiries_aggregate(where: $where) {
    aggregate {
      count
    }
  }

  pending: talent_enquiries_aggregate(
    where: { _and: [$where, { job_profiles: { admin_status: { _eq: "PENDING" } } }] }
  ) {
    aggregate {
      count
    }
  }

  approved: talent_enquiries_aggregate(
    where: { _and: [$where, { job_profiles: { admin_status: { _eq: "APPROVE" } } }] }
  ) {
    aggregate {
      count
    }
  }

  expired: talent_enquiries_aggregate(
    where: { _and: [$where, { job_profiles: { admin_status: { _eq: "EXPIRED" } } }] }
  ) {
    aggregate {
      count
    }
  }

  draft: talent_enquiries_aggregate(
    where: { _and: [$where, { job_profiles: { admin_status: { _eq: "DRAFT" } } }] }
  ) {
    aggregate {
      count
    }
  }

  rejected: talent_enquiries_aggregate(
    where: { _and: [$where, { job_profiles: { admin_status: { _eq: "REJECT" } } }] }
  ) {
    aggregate {
      count
    }
  }
}

''';
