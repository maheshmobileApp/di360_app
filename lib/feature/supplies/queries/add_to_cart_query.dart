const String addToCartQuery =
    r'''mutation insert_supply_carts_one($supply_carts: supply_carts_insert_input!) {
  insert_supply_carts_one(object: $supply_carts) {
    id
    __typename
  }
}''';
