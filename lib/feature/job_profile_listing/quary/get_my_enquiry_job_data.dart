const String getMyEnquiryJobDataQuery =
    r'''query getMyEnquiryJobData($limit: Int, $offset: Int, $where: talent_enquiries_bool_exp) {
  talent_enquiries(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {enquiry_from: asc, created_at: asc}
    distinct_on: enquiry_from
  ) {
    id
    created_at
    talent_id
    enquiry_from
    dental_practices {
      id
      name
      logo
      directories {
        id
        email
        phone
        __typename
      }
      __typename
    }
    dental_suppliers {
      id
      name
      logo
      directories {
        id
        email
        phone
        __typename
      }
      __typename
    }
    jobhirings_find_practice {
      id
      __typename
    }
    jobhirings_find_supplier {
      id
      __typename
    }
    __typename
  }
}
''';
