const String viewOrderQuery =
    r'''query supplies_orders_by_pk($id: uuid!, $user_id: uuid!) {
  supplies_orders_by_pk(id: $id) {
    id
    created_at
    updated_at
    short_id
    supply_coupon_id
    total_amount
    tax_amount
    tax_percentage
    delivery_charge
    estimated_delivery_in_days
    status
    is_confirmed
    payment_status
    payment_mode
    billing_address
    shipping_address
    online_payment_order_id
    online_payment_transaction_id
    online_payment_signature
    approved_on
    approved_message
    shipped_on
    shipped_message
    delivered_on
    delivered_message
    cancelled_on
    canceled_message
    refunded_on
    refunded_message
    custom_message
    dental_practice_id
    dental_practice {
      id
      name
      phone
      __typename
    }
    dental_professional_id
    dental_professional {
      id
      name
      phone
      __typename
    }
    dental_supplier_id
    dental_supplier {
      id
      name
      phone
      __typename
    }
    account_pay_details
    suppliers_id
    supplier {
      id
      name
      logo
      business_name
      email
      phone
      __typename
    }
    coupon_discount
    sub_total
    order_number
    supplies_order_items(order_by: {created_at: desc}) {
      id
      created_at
      price
      quantity
      supplies_order_id
      supply_id
      sent_quantity
      status
      supply {
        id
        name
        __typename
      }
      supply_deal_id
      supply_deal {
        id
        name
        type
        buy_quantity
        get_quantity
        price
        description
        image
        __typename
      }
      free_quantity
      supply_variant_attributes
      supply_variant_id
      supply_variant {
        id
        title
        actual_price
        attributes
        available_stock
        color
        created_at
        details
        image
        sku_code
        selling_price
        stock_unit
        price_unit
        make_default
        supply_reviews_aggregate(
          where: {_or: [{dental_practice_id: {_eq: $user_id}}, {dental_professional_id: {_eq: $user_id}}, {dental_supplier_id: {_eq: $user_id}}]}
        ) {
          aggregate {
            count
            __typename
          }
          __typename
        }
        __typename
      }
      updated_at
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
      created_by
      created_at
      supply_dispatch_items {
        id
        supplies_order_item_id
        dispatch_quantity
        backorder_quantity
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
    supplies_order_notes {
      id
      created_at
      updated_at
      supplies_order_id
      status
      message
      extra
      __typename
    }
    __typename
  }
}''';
