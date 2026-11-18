const String suppliesEnquiriesQuery =
    r'''query supply_enquiries($sort: [supply_enquiries_order_by!], $andList: [supply_enquiries_bool_exp!], $limit: Int, $offset: Int) {
  supply_enquiries(
    where: {_and: $andList}
    order_by: $sort
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    supply_id
    supply {
      id
      name
      image
      __typename
    }
    supply_variant_id
    supply_variant {
      id
      title
      image
      __typename
    }
    message
    attachments
    type
    dental_supplier_id
    dental_supplier {
      id
      name
      email
      phone
      __typename
    }
    dental_professional_id
    dental_professional {
      id
      name
      email
      phone
      __typename
    }
    dental_practice_id
    dental_practice {
      id
      name
      email
      phone
      __typename
    }
    __typename
  }
}''';

const getSuppliesEnquiriesTwoQuery = r'''
query supply_enquiries($sort: [supply_enquiries_order_by!], $userId: uuid, $search: String, $limit: Int, $offset: Int) {
  supply_enquiries(
    where: {_or: [{dental_supplier_id: {_eq: $userId}}, {dental_practice_id: {_eq: $userId}}, {dental_professional_id: {_eq: $userId}}], supply: {name: {_ilike: $search}}}
    order_by: $sort
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    supply_id
    supply {
      id
      name
      image
      __typename
    }
    supply_variant_id
    supply_variant {
      id
      title
      image
      __typename
    }
    message
    attachments
    type
    dental_supplier_id
    dental_supplier {
      id
      name
      email
      phone
      __typename
    }
    dental_professional_id
    dental_professional {
      id
      name
      email
      phone
      __typename
    }
    dental_practice_id
    dental_practice {
      id
      name
      email
      phone
      __typename
    }
    __typename
  }
}''';
