const String getJobListingQuary = r'''
    query getjobposts($limit: Int, $offset: Int, $status: String) {
  jobs(limit: $limit, offset: $offset, where: {status: {_eq: $status}}) {
    id   
    created_at   
    logo
    company_name
    description
    title    
    education
    experience
    pay_range
    j_role
    j_type
    TypeofEmployment
    location
    address
    roles_and_responsibilities
    short_id
    status
  }
} ''';
