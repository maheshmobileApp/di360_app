const String viewOrderQuery = r'''query supplies_orders_by_pk($id: uuid!) {
  supplies_orders_by_pk(id: $id) {
    id
    created_at
    total_amount
    sub_total
    coupon_discount
    delivery_charge
    tax_amount
    tax_percentage
    status
    is_confirmed
    order_number
    dental_practice {
      id
      name
      business_name
      zipcode
      state
      city
      address_line_one
      address_line_two
      land_mark
      __typename
    }
    dental_professional {
      id
      name
      zipcode
      state
      city
      address_line_one
      address_line_two
      land_mark
      __typename
    }
    shipping_address
    supplies_order_items(order_by: {created_at: desc}) {
      id
      quantity
      price
      free_quantity
      status
      supply {
        name
        price_type
        __typename
      }
      supply_variant {
        title
        sku_code
        color
        image
        selling_price
        calculated_price
        __typename
      }
      supply_dispatch_items(order_by: {created_at: desc}) {
        id
        supply_dispatch_id
        dispatch_quantity
        price
        status
        supply_dispatch {
          status
          __typename
        }
        __typename
      }
      __typename
    }
    supply_dispatch(order_by: {created_at: desc}) {
      id
      dispatch_number
      invoice_number
      postal_service
      tracking_number
      dispatch_notes
      invoice_file
      status
      dispatch_date
      created_at
      updated_at
      supply_dispatch_items {
        id
        supplies_order_item_id
        dispatch_quantity
        price
        status
        __typename
      }
      __typename
    }
    supplies_order_history(order_by: {created_at: desc}) {
      id
      event_type
      status_snapshot
      invoice_number
      postal_service
      tracking_number
      supply_dispatch_id
      version_number
      created_at
      __typename
    }
    __typename
  }
}''';
