const String deleteCartItemQuery =
    r'''mutation delete_supply_carts_by_pk($id: uuid!) {
  delete_supply_carts_by_pk(id: $id) {
    id
    __typename
  }
}''';
