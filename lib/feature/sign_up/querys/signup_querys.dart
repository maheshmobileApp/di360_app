const String subscriptionQuery = '''
    query getSubPlan {
      subscription_plans(
        where: {plan_type: {_eq: "REGULAR"}, plan_status: {_eq: "ACTIVE"}}
      ) {
        id
        updated_at
        name
        price_in_aud
        price_in_usd
        tenure_in_days
        tenure_type
        terms_and_conditions
        type
        description
        benefits
        plan_type
        monthy_price
        yearly_price
        plan_status
        __typename
      }
    }
  ''';

const String businessQuery = '''
      query getBusinessTypes(\$type: String!) {
  directory_business_types(where: {type: {_eq: \$type}}) {
    id
    type
    name
    directory_categories {
      id
      name
      __typename
    }
    __typename
  }
}
  ''';

const String singUpQuery = '''
mutation signUp(\$signUpObj: clients_insert_input!) {  insert_clients_one(object: \$signUpObj) {  
  id    
  email   
  phone
  type
  name   
  __typename}

}
  ''';