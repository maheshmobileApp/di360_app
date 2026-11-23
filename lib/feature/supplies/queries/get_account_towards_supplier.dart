const String getAccountTowardsSupplierQuery =
    r'''query get_account_towards_supplier($supplier_id: uuid!) {
  supplier_accounts(where: {supplier_id: {_eq: $supplier_id}}) {
    id
    account_number
    supplier_id
    supplier {
      id
      name
      __typename
    }
    dental_supplier_id
    dental_supplier {
      id
      name
      __typename
    }
    dental_practice_id
    dental_practice {
      id
      name
      __typename
    }
    dental_professional_id
    dental_professional {
      id
      name
      __typename
    }
    __typename
  }
}
''';
