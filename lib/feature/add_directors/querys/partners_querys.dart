const String getPartnersQuery = r'''
query GetPartnership($directory_id: uuid!) {
  directories_partners_members(
    where: {directory_id: {_eq: $directory_id}}
    order_by: {created_at: desc}
  ) {
    id
    name
    image
    attachments
    description
    show_community_user
    directory_id
    __typename
  }
}
''';

const String addPartnersQuery = r'''
mutation AddPartnership($partnershipObj: directories_partners_members_insert_input!) {
  insert_directories_partners_members_one(object: $partnershipObj) {
    id
    __typename
  }
}
''';

const String deletePartnersQuery = r'''
mutation RemovePartnership($id: uuid!) {
  delete_directories_partners_members(where: {id: {_eq: $id}}) {
    affected_rows
    __typename
  }
}
''';

const String updatePartnersQuery = r'''
mutation UpdatePartnership($id: uuid!, $partnershipObj: directories_partners_members_set_input!) {
  update_directories_partners_members_by_pk(
    pk_columns: {id: $id}
    _set: $partnershipObj
  ) {
    id
    __typename
  }
}
''';
