const String getShippingChargesQuery =
    r'''query get_freight_ranges($where: freight_ranges_bool_exp!) {
  freight_ranges(where: $where) {
    id
    shipping_rule
    shipping_cost
    min_order_value
    min_no_products
    std_est_delivery
    express_post_enabled
    express_post_cost
    express_delivery_eta
    is_active
    __typename
  }
}''';
