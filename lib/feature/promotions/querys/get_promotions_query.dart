const String getPromotionsQuery =
    r'''query promotionPage($where: supply_promotions_bool_exp!, $active: supply_promotions_bool_exp!, $inactive: supply_promotions_bool_exp!, $expired: supply_promotions_bool_exp!, $limit: Int!, $offset: Int!) {
  supply_promotions(
    where: $where
    limit: $limit
    offset: $offset
    order_by: [{created_at: desc}, {id: desc}]
  ) {
    id
    name
    type
    scope
    status
    is_active
    start_date
    end_date
    applies_to_all_products
    config
    supply_promotion_items {
      supply_id
      item_role
      supply {
        name
        supply_variants {
          id
          sku_code
          __typename
        }
        __typename
      }
      __typename
    }
    __typename
  }
  total: supply_promotions_aggregate(where: $where) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  active: supply_promotions_aggregate(where: $active) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  inactive: supply_promotions_aggregate(where: $inactive) {
    aggregate {
      count
      __typename
    }
    __typename
  }
  expired: supply_promotions_aggregate(where: $expired) {
    aggregate {
      count
      __typename
    }
    __typename
  }
}''';
