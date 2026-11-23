const String supplyFavouritesQuery =
    r'''query supply_favorites($limit: Int, $offset: Int, $where: supply_favorites_bool_exp) {
  supply_favorites(where: $where, limit: $limit, offset: $offset) {
    id
    supply_id
    supply_variant_id
    created_at
    updated_at
    supply {
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
      supply_brand_id
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
    supply_variant {
      id
      created_at
      updated_at
      actual_price
      attributes
      sku_code
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
    __typename
  }
}''';
