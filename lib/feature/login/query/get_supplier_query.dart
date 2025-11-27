const String getSupplierQuery = r'''query getSupplier($id: uuid!) {
  dental_suppliers_by_pk(id: $id) {
    id
    second_hand
    sell_products
    profile_completed
    stripe_customer_id
    directories {
      directory_category_id
      __typename
    }
    present_subscription_id
    user_subscriptions {
      id
      payment_status
      __typename
    }
    __typename
  }
}
''';
