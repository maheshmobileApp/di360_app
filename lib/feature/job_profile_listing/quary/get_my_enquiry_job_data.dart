const String getMyEnquiryJobDataQuery =
    r'''query getMyEnquiries($limit: Int, $offset: Int, $where: talent_enquiries_bool_exp) {
  talent_enquiries(
    where: $where
    limit: $limit
    offset: $offset
    order_by: [{enq_sender_id: asc}, {created_at: asc}]
    distinct_on: [enq_sender_id]
  ) {
    id
    created_at
    talent_id
    enq_sender_id
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
