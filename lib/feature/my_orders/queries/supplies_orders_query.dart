const String suppliesOrdersQuery =
    r'''query supplies_orders($andList: [supplies_orders_bool_exp!], $limit: Int, $offset: Int) {
  supplies_orders(
    where: {_and: $andList}
    limit: $limit
    offset: $offset
    order_by: {order_number: desc}
  ) {
    id
    created_at
    updated_at
    short_id
    supply_coupon_id
    total_amount
    tax_amount
    delivery_charge
    estimated_delivery_in_days
    status
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
      email
      __typename
    }
    dental_professional_id
    dental_professional {
      id
      name
      phone
      email
      __typename
    }
    dental_supplier_id
    dental_supplier {
      id
      name
      phone
      email
      __typename
    }
    supplier {
      business_name
      name
      email
      __typename
    }
    account_pay_details
    suppliers_id
    coupon_discount
    sub_total
    order_number
    supplies_order_notes {
      id
      created_at
      updated_at
      supplies_order_id
      status
      message
      __typename
    }
    __typename
  }
}''';
