const String purchasedItemsQuery =
    r'''query purchased_order_items($buyer: supplies_orders_bool_exp!) {
  supplies_order_items(
    order_by: {created_at: desc}
    where: {status: {_neq: "CANCELLED"}, supplies_order: $buyer}
  ) {
    id
    created_at
    quantity
    sent_quantity
    price
    supply_id
    supply_variant_id
    supplies_order_id
    supply {
      id
      name
      image
      supply_brand {
        name
        __typename
      }
      supply_category {
        name
        __typename
      }
      __typename
    }
    supply_variant {
      id
      title
      sku_code
      selling_price
      available_stock
      image
      color
      __typename
    }
    supplies_order {
      id
      status
      created_at
      dental_supplier_id
      supplier {
        id
        business_name
        __typename
      }
      __typename
    }
    __typename
  }
}''';
