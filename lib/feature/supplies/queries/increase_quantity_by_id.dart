const String increaseQuantityById = r'''mutation increaseQuantityBy($id: uuid!, $amount: Int!) {
  update_supply_carts_by_pk(pk_columns: {id: $id}, _inc: {quantity: $amount}) {
    id
    __typename
  }
}''';