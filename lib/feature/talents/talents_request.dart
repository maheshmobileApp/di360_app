String talentsRequest =
    r'''query getMarketPlaceTalents($limit: Int, $offset: Int, $where: job_profiles_bool_exp, $order_by: [job_profiles_order_by!], $loginId: uuid!) {
  job_profiles(where: $where, order_by: $order_by, limit: $limit, offset: $offset) {
    id
    created_at
    updated_at
    jobexperiences
    job_designation
    dental_professional_id
    post_anonymously
    admin_status
    profile_image
    full_name
    work_type
    profession_type
    location
    country
    city
    state
    availabilityDay
    Year_of_experiance
    percentage
    about_yourself
    dental_professional {
      id
      gender
      __typename
    }
    jobhirings(
      where: {_or: [{dental_supplier_id: {_eq: $loginId}}, {dental_practice_id: {_eq: $loginId}}]}
      order_by: {created_at: desc}
    ) {
      id
      dental_supplier_id
      hiring_status
      dental_practice_id
      __typename
    }
    __typename
  }
}
''';

String hireMeMutation = r'''
mutation insert_jobhirings($hireobject:jobhirings_insert_input!) {
  insert_jobhirings_one(object: $hireobject) {
    id
  }
}''';

String hireMeTalentMutation =
    r'''mutation insert_jobpost($jobHiringsDetails: jobhirings_insert_input!) {
  insert_jobhirings_one(object: $jobHiringsDetails) {
    id
    __typename
  }
}''';

String enquiryMutation =
    r'''mutation insert_Enquiry_one($object: talent_enquiries_insert_input!) {
  insert_talent_enquiries_one(object: $object) {
    id
    __typename
  }
} ''';

String GetJobProfileFilterData = r'''
query getMarketPlaceTalents($limit: Int, $offset: Int, $where: job_profiles_bool_exp, $order_by: [job_profiles_order_by!], $loginId: uuid!) {
  job_profiles(where: $where, order_by: $order_by, limit: $limit, offset: $offset) {
    id
    created_at
    updated_at
    jobexperiences
    job_designation
    dental_professional_id
    post_anonymously
    admin_status
    profile_image
    full_name
    work_type
    profession_type
    location
    country
    city
    state
    availabilityDay
    Year_of_experiance
    percentage
    about_yourself
    dental_professional {
      id
      gender
      __typename
    }
    jobhirings(
      where: {_or: [{dental_supplier_id: {_eq: $loginId}}, {dental_practice_id: {_eq: $loginId}}]}
      order_by: {created_at: desc}
    ) {
      id
      dental_supplier_id
      hiring_status
      dental_practice_id
      __typename
    }
    __typename
  }
}
''';
/*


{
  "object": {
    "enquiry_description": "Can u call me",
    "talent_id": "693105b7-030d-45c0-8dfc-4cffd5572451",
    "enquiry_from": "7306adc6-1efa-4a52-8c82-7e4e1922a5c5"
  }
}
 */
