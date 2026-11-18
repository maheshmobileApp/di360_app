const String suppliesEnquiryDetailViewQuery =
    r'''query supply_enquiries_by_pk($id: uuid!) {
  supply_enquiries_by_pk(id: $id) {
    id
    created_at
    updated_at
    supply_id
    supply {
      id
      name
      image
      supply_brand {
        id
        name
        __typename
      }
      supply_category {
        id
        name
        __typename
      }
      supply_sub_category {
        id
        name
        __typename
      }
      __typename
    }
    supply_variant_id
    supply_variant {
      id
      title
      image
      actual_price
      selling_price
      __typename
    }
    message
    attachments
    reply
    reply_attachments
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
