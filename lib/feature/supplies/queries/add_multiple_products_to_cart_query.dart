const String addMultipleProductstoCartQuery =
    r'''mutation AddMultipleSupplyCarts($objects: [supply_carts_insert_input!]!) {
  insert_supply_carts(
    objects: $objects
    on_conflict: {constraint: supply_carts_supply_id_supply_variant_id_dental_practice_id_key, update_columns: [quantity]}
  ) {
    affected_rows
    __typename
  }
}''';
