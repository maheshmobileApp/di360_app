const String getTalentListingQuery = r'''
query getHiringTalentList($where: jobhirings_bool_exp, $limit: Int, $offset: Int) {
  jobhirings(
    where: $where
    limit: $limit
    offset: $offset
    order_by: {updated_at: desc}
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
      name
      profile_image
      logo
      __typename
    }
    dental_practice {
      id
      name
      profile_image
      logo
      __typename
    }
    job_profiles {
      id
      full_name
      profession_type
      state
      profile_image
      work_type
      dental_professional_id
      post_anonymously
      dental_professional {
        gender
        profile_image
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
    directories {
      dental_supplier_id
      logo
      __typename
    }
    __typename
  }
}

''';

