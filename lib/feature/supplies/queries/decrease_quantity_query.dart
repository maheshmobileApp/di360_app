const decreaseQuantityQuery = r'''mutation decreaseQuantity($id: uuid!) {
  update_supply_carts_by_pk(pk_columns: {id: $id}, _inc: {quantity: -1}) {
    id
    __typename
  }
}''';
