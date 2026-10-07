const String getSuppliesDetailsQuery = r'''query get_supply_by_pk($id: uuid!) {
  supplies(where: {id: {_eq: $id}, product_status: {_eq: "ACTIVE"}}) {
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
    seo_metadata
    short_id
    short_info
    sku
    specifications
    status
    product_status
    product_type
    product_condition
    doc_msds
    doc_spec_sheet
    doc_brochure
    doc_manual
    doc_warranty
    supply_brand_id
    deal
    supply_brand {
      id
      name
      __typename
    }
    supply_category_id
    supply_category {
      id
      name
      __typename
    }
    supply_sub_category_id
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
    dental_suppliers_id
    dental_supplier {
      id
      name
      logo
      business_name
      __typename
    }
    __typename
  }
}''';
