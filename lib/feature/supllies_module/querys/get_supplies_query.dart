const String getSuppliesQuery =
    r'''query supplies($andList: [supplies_bool_exp!], $sortList: [supplies_order_by!], $limit: Int, $offset: Int) {
  supplies(
    where: {_and: $andList}
    order_by: $sortList
    limit: $limit
    offset: $offset
  ) {
    id
    created_at
    updated_at
    name
    details
    image
    is_featured
    more_images
    page_title
    seo_metadata
    short_id
    short_info
    sku
    min_stock
    product_type
    specifications
    status
    product_status
    supply_brand_id
    gst_applicable
    gst_rate
    price_type
    supply_brand {
      id
      name
      __typename
    }
    supply_variants {
      id
      specifications
      title
      selling_price
      calculated_price
      supply_id
      status
      available_stock
      make_default
      price_unit
      stock_unit
      sku_code
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
    rejection_reason
    deal
    dental_suppliers_id
    dental_supplier {
      id
      name
      business_name
      __typename
    }
    __typename
  }
}''';
