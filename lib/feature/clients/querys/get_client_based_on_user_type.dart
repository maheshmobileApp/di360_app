const String getClientBasedOnUserTypeQuery = r'''
query GetClientCounts {

  # PRACTICE
  practiceTotal: clients_aggregate(
    where: { type: { _eq: "PRACTICE" } }
  ) {
    aggregate { count }
  }

  practiceActive: clients_aggregate(
    where: {
    type: { _eq: "PRACTICE" }
      status: { _neq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  practiceInactive: clients_aggregate(
    where: {
    type: { _eq: "PRACTICE" }
      status: { _eq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  # SUPPLIER(excluding Team Members)
  supplierTotal: clients_aggregate(
    where: {
    type: { _eq: "SUPPLIER" }
      _or: [
      { sub_type: { _neq: "SUB_SUPPLIER" } }
        { sub_type: { _is_null: true } }
    ]
  }
  ) {
    aggregate { count }
  }

  supplierActive: clients_aggregate(
    where: {
    type: { _eq: "SUPPLIER" }
      _or: [
      { sub_type: { _neq: "SUB_SUPPLIER" } }
        { sub_type: { _is_null: true } }
    ]
      status: { _neq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  supplierInactive: clients_aggregate(
    where: {
    type: { _eq: "SUPPLIER" }
      _or: [
      { sub_type: { _neq: "SUB_SUPPLIER" } }
        { sub_type: { _is_null: true } }
    ]
      status: { _eq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  # PROFESSIONAL
  professionalTotal: clients_aggregate(
    where: { type: { _eq: "PROFESSIONAL" } }
  ) {
    aggregate { count }
  }

  professionalActive: clients_aggregate(
    where: {
    type: { _eq: "PROFESSIONAL" }
      status: { _neq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  professionalInactive: clients_aggregate(
    where: {
    type: { _eq: "PROFESSIONAL" }
      status: { _eq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  # TEAM MEMBERS
  teamMemberTotal: clients_aggregate(
    where: {
    type: { _eq: "SUPPLIER" }
      sub_type: { _eq: "SUB_SUPPLIER" }
  }
  ) {
    aggregate { count }
  }
	
  teamMemberActive: clients_aggregate(
    where: {
    type: { _eq: "SUPPLIER" }
      sub_type: { _eq: "SUB_SUPPLIER" }
      status: { _neq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  teamMemberInactive: clients_aggregate(
    where: {
    type: { _eq: "SUPPLIER" }
      sub_type: { _eq: "SUB_SUPPLIER" }
      status: { _eq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  # ALL USERS(excluding Team Members)
  allTotal: clients_aggregate(
    where: {
    _or: [
      { type: { _eq: "PRACTICE" } }
        { type: { _eq: "PROFESSIONAL" } }
        {
        _and: [
          { type: { _eq: "SUPPLIER" } }
            {
            _or: [
              { sub_type: { _neq: "SUB_SUPPLIER" } }
                { sub_type: { _is_null: true } }
            ]
          }
        ]
      }
    ]
  }
  ) {
    aggregate { count }
  }

  allActive: clients_aggregate(
    where: {
    _or: [
      { type: { _eq: "PRACTICE" } }
        { type: { _eq: "PROFESSIONAL" } }
        {
        _and: [
          { type: { _eq: "SUPPLIER" } }
            {
            _or: [
              { sub_type: { _neq: "SUB_SUPPLIER" } }
                { sub_type: { _is_null: true } }
            ]
          }
        ]
      }
    ]
      status: { _neq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }

  allInactive: clients_aggregate(
    where: {
    _or: [
      { type: { _eq: "PRACTICE" } }
        { type: { _eq: "PROFESSIONAL" } }
        {
        _and: [
          { type: { _eq: "SUPPLIER" } }
            {
            _or: [
              { sub_type: { _neq: "SUB_SUPPLIER" } }
                { sub_type: { _is_null: true } }
            ]
          }
        ]
      }
    ]
      status: { _eq: "INACTIVE" }
  }
  ) {
    aggregate { count }
  }
}
''';