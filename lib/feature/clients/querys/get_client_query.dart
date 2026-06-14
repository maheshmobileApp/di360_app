const String getClientQuery = r'''
query GET_ALL_CLIENTS_QUERY {
  clients {
    abn_number
    blocked_at
    blocked_reason
    businessName
    business_name
    client_verification_key
    client_verified
    country
    created_at
    credits
    dashboard_status
    directory_business_type_id
    directory_category_other_name
    email
    employee_details
    first_name
    id
    internal_note
    last_name
    manager_user_id
    name
    password
    payload
    payment_status
    phone
    postal_code
    professionType
    profile_status
    state
    status
    subscription_expires_at
    subscription_plan_id
    timezone
    tracking_details
    type
    updated_at
    sub_type
    subscription_plans {
      id
      name
      __typename
    }
    client_source {
      id
      name
      __typename
    }
    __typename
  }
}
''';
