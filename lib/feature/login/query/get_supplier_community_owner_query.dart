const String getSupplierCommunityOwnerQuery =
    r'''query getSupplierCommunityOwner($dental_supplier_id: uuid!) {
  dental_suppliers(where: {id: {_eq: $dental_supplier_id}}, limit: 1) {
    id
    community_id
    community_status
    business_name
    __typename
  }
}
''';
