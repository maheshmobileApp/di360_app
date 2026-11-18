const String addFavouriteQuery =
    r'''mutation insert_supply_favorites_one($supply_favorites: supply_favorites_insert_input!) {
  insert_supply_favorites_one(object: $supply_favorites) {
    id
    __typename
  }
}''';
