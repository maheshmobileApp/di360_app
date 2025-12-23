const String getTalentEnquiryQuery = r'''
query getTalentsEnquiry($where: talent_enquiries_bool_exp!) {
  talent_enquiries(where: $where, order_by: {created_at: asc}) {
    id
    talent_id
    created_at
    updated_at
    enquiry_from
    enquiry_description
    __typename
  }
}

''';



