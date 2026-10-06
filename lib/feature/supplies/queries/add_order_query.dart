const String addOrderQuery =
    r'''mutation add_supplies_orders_one($supplies_orders: OrderInput!) {
  addOrder(details: $supplies_orders) {
    id
    order_number
    payment_intent
    __typename
  }
}''';
