const String getSuppliesCartQuery = r'''query supply_carts {
  supply_carts(order_by: {created_at: desc}) {
    id
    created_at
    updated_at
    quantity
    supply_id
    supply {
      id
      name
      dental_suppliers_id
      image
      dental_supplier {
        id
        name
        business_name
        __typename
      }
      j_supply_deals_supplies(
        where: {supply_deal: {start: {_lte: "now()"}, end: {_gte: "now()"}}}
      ) {
        supply_id
        supply_deal_id
        supply_deal {
          id
          name
          image
          buy_quantity
          get_quantity
          start
          end
          type
          description
          price
          deal_on
          image
          __typename
        }
        __typename
      }
      __typename
    }
    supply_variant_id
    supply_variant {
      id
      title
      color
      actual_price
      sku_code
      selling_price
      image
      available_stock
      __typename
    }
    supply_deal_id
    free_quantity
    __typename
  }
}''';
