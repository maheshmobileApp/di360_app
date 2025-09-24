const String getBannerCountQuery= r'''
query getBannersCount {
  banners {
    id
    banner_name
    category_name
    status
    expiry_date
    image
    schedule_date
    created_at
    updated_at
    from_id
    views
    url
    company_name
    dental_suppliers {
      name
    }
  }

  approved: banners_aggregate(
    where: { status: { _eq: "APPROVE" } }
  ) {
    aggregate {
      count
    }
  }

  rejected: banners_aggregate(
    where: { status: { _eq: "REJECT" } }
  ) {
    aggregate {
      count
    }
  }

  pending: banners_aggregate(
    where: { status: { _eq: "PENDING" } }
  ) {
    aggregate {
      count
    }
  }
}
  ''';