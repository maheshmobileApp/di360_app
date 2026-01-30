String getAllTalentsRequestQuery = r'''query getAllTalentsRequest($where: jobhirings_bool_exp, $limit: Int, $offset: Int) {
  jobhirings(
    where: $where
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    dental_professional_id
    dental_supplier_id
    hiring_status
    updated_at
    created_at
    job_profiles_id
    dental_practice_id
    dental_supplier {
      id
      logo
      name
      directories {
        id
        email
        phone
        __typename
      }
      __typename
    }
    dental_practice {
      id
      logo
      name
      directories {
        id
        email
        phone
        __typename
      }
      __typename
    }
    talent_enquiries_find_practice {
      id
      __typename
    }
    talent_enquiries_find_supplier {
      id
      __typename
    }
    __typename
  }
}
''';