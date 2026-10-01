const String favouritesKeysQuery = r'''query favorite_product_keys {
  supply_favorites {
    supply_id
    supply_variant_id
    __typename
  }
}''';
