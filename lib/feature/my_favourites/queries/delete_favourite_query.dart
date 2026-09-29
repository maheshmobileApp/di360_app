const String deleteFavouriteQuery =
    r'''mutation delete_supply_favorites($supplyId: uuid, $supplyVariantId: uuid) {
  delete_supply_favorites(
    where: {supply_id: {_eq: $supplyId}, supply_variant_id: {_eq: $supplyVariantId}}
  ) {
    affected_rows
    __typename
  }
}''';
