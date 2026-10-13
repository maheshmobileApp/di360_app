String get loginSchema => r"""mutation loginApi($details: LoginInput!) {
  login_api(details: $details) {
    id
    accessToken
    refreshToken
    name
    email
    phone
    logo
    status
    message
    profile_completed
    payment_completed
    profile_image
    type
    address
    directory_category_id
    professionType
    second_hand
    business_name
    abn_number
    gender
    sell_products
    dashboard_permissions
    plan_id
    payment_status
    subscription_id
    subscription_permissions
    sub_type
    owner_id
    professiontype
    __typename
  }
}
""";

final String getSupplier = '''
    query getSupplier(\$id: uuid!) {
      dental_suppliers_by_pk(id: \$id) {
        id
        name
        email
        phone
        type
        subsciption_plan_id
        present_subscription_id
        profile_image
      }
    }
  ''';

final String getPractice = '''
    query getPractice(\$id: uuid!) {
      dental_practices_by_pk(id: \$id) {
        id
        name
        email
        phone
        type
        subsciption_plan_id
        present_subscription_id
        profile_image
      }
    }
  ''';

final String getProfessional = '''
    query getProfessional(\$id: uuid!){
    dental_professionals_by_pk(id:\$id){
        id
        email
        name
        phone
        first_name
        last_name
        type
        subsciption_plan_id
        present_subscription_id
        profile_image
 }
}
  ''';
