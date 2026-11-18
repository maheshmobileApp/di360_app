const String suppliesDetailQuery = r'''query get_supply_by_pk($id: uuid!) {
  supplies_by_pk(id: $id) {
    id
    created_at
    updated_at
    name
    alt_text_of_image
    details
    image
    is_featured
    more_images
    page_title
    min_stock
    seo_metadata
    product_type
    product_condition
    doc_msds
    doc_manual
    doc_warranty
    doc_spec_sheet
    doc_brochure
    short_id
    short_info
    sku
    gst_applicable
    gst_rate
    price_type
    specifications
    status
    product_status
    supply_brand_id
    other_brand_name
    deal
    supply_brand {
      id
      name
      __typename
    }
    supply_category_id
    other_category_name
    supply_category {
      id
      name
      __typename
    }
    supply_sub_category_id
    other_sub_category_name
    supply_sub_category {
      id
      name
      __typename
    }
    video
    supply_variants {
      id
      created_at
      updated_at
      actual_price
      attributes
      available_stock
      color
      details
      image
      make_default
      more_images
      price_unit
      selling_price
      specifications
      status
      stock_unit
      supply_id
      title
      video
      sku_code
      __typename
    }
    tags: j_supplies_supply_tags {
      id
      supply_tag {
        id
        name
        __typename
      }
      __typename
    }
    supply_reviews {
      id
      created_at
      updated_at
      supply_id
      supply_variant_id
      rating
      message
      attachments
      status
      type
      dental_supplier_id
      dental_supplier {
        id
        name
        phone
        email
        profile_image
        __typename
      }
      dental_professional_id
      dental_professional {
        id
        name
        phone
        email
        profile_image
        __typename
      }
      dental_practice_id
      dental_practice {
        id
        name
        phone
        email
        profile_image
        __typename
      }
      __typename
    }
    __typename
  }
}''';