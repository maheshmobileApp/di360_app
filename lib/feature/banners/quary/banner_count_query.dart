const String getBannersCountQuery = r'''
query getBannersCount($from_id: uuid!) {
   ALL: banners_aggregate(
    where: { from_id: { _eq: $from_id } }
  ) {
    aggregate {
      count
    }
  }
  approved: banners_aggregate(
    where: { status: { _eq: "APPROVED" }, from_id: { _eq: $from_id } }
  ) {
    aggregate {
      count
    }
  }

  rejected: banners_aggregate(
    where: { status: { _eq: "REJECTED" }, from_id: { _eq: $from_id } }
  ) {
    aggregate {
      count
    }
  }

  pending: banners_aggregate(
    where: { status: { _eq: "PENDING" }, from_id: { _eq: $from_id } }
  ) {
    aggregate {
      count
    }
  }

  expired: banners_aggregate(
    where: { status: { _eq: "EXPIRED" }, from_id: { _eq: $from_id } }
  ) {
    aggregate {
      count
    }
  }
    shecduled: banners_aggregate(
    where: { status: { _eq: "SCHEDULED" }, from_id: { _eq: $from_id } }
  ) {
    aggregate {
      count
    }
  }
   draft: banners_aggregate(
    where: { status: { _eq: "DRAFT" }, from_id: { _eq: $from_id } }
  ) {
    aggregate {
      count
    }
  }
}
''';
