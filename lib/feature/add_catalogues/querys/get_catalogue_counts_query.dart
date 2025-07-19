const String GetCatalogueCountsQuery = r'''
query GetCatalogueStatusCounts($title: String!, $categoryName: String!, $supplierId: uuid!) {
  all: catalogues_aggregate(
    where: {
      status: {_eq: "APPROVED"},
      title: {_ilike: $title},
      catalogue_category: {name: {_ilike: $categoryName}},
      dental_supplier_id: {_eq: $supplierId}
    }
  ) {
    aggregate {
      count
    }
  }
  approved: catalogues_aggregate(
    where: {
      status: {_eq: "APPROVED"},
      title: {_ilike: $title},
      catalogue_category: {name: {_ilike: $categoryName}},
      dental_supplier_id: {_eq: $supplierId}
    }
  ) {
    aggregate {
      count
    }
  }
  pending: catalogues_aggregate(
    where: {
      status: {_eq: "PENDING_APPROVAL"},
      title: {_ilike: $title},
      catalogue_category: {name: {_ilike: $categoryName}},
      dental_supplier_id: {_eq: $supplierId}
    }
  ) {
    aggregate {
      count
    }
  }
  rejected: catalogues_aggregate(
    where: {
      status: {_eq: "REJECTED"},
      title: {_ilike: $title},
      catalogue_category: {name: {_ilike: $categoryName}},
      dental_supplier_id: {_eq: $supplierId}
    }
  ) {
    aggregate {
      count
    }
  }
  expired: catalogues_aggregate(
    where: {
      status: {_eq: "EXPIRED"},
      title: {_ilike: $title},
      catalogue_category: {name: {_ilike: $categoryName}},
      dental_supplier_id: {_eq: $supplierId}
    }
  ) {
    aggregate {
      count
    }
  }
  draft: catalogues_aggregate(
    where: {
      status: {_eq: "DRAFT"},
      title: {_ilike: $title},
      catalogue_category: {name: {_ilike: $categoryName}},
      dental_supplier_id: {_eq: $supplierId}
    }
  ) {
    aggregate {
      count
    }
  }
  scheduled: catalogues_aggregate(
    where: {
      status: {_eq: "SCHEDULED"},
      title: {_ilike: $title},
      catalogue_category: {name: {_ilike: $categoryName}},
      dental_supplier_id: {_eq: $supplierId}
    }
  ) {
    aggregate {
      count
    }
  }
}
''';