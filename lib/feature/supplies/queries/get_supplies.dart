const String getSupplies =
    r'''query supplies($andList: [supplies_bool_exp!], $limit: Int, $offset: Int) {
  supplies(
    where: {_and: $andList}
    order_by: {updated_at: desc}
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
    specifications
    status
    product_status
    supply_brand_id
    supply_brand {
      id
      name
      __typename
    }
    supply_category_id
    supply_sub_category_id
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
      supply_reviews_aggregate {
        aggregate {
          count
          sum {
            rating
            __typename
          }
          __typename
        }
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
    j_supply_deals_supplies(
      where: {supply_deal: {start: {_lte: "now()"}, end: {_gte: "now()"}}}
      order_by: {created_at: desc}
    ) {
      id
      supply_id
      supply_deal_id
      supply_deal {
        id
        name
        image
        type
        __typename
      }
      __typename
    }
    __typename
  }
}''';
