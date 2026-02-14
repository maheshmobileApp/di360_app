const String getProfessionalNotifications = r'''
query get_notifications(
  $user_id: uuid!
  $limit: Int!
  $offset: Int!
) {
  notifications: dental_professional_notifications(
    where: {
      dental_professional_id: { _eq: $user_id }
      mark_as_read: { _eq: false }
    }
    order_by: { created_at: desc }
    limit: $limit
    offset: $offset
  ) {
    id
    title
    type
    body
    payload
    image
    mark_as_read
    read_at
    status
    dental_professional_id
    created_at
    updated_at
    __typename
  }
}
''';

const String updateProfessionalNotification = r'''
mutation update_dental_professional_notifications_by_pk($id: uuid!) {
  update_dental_professional_notifications_by_pk(
    pk_columns: {id: $id}
    _set: {mark_as_read: true}
  ) {
    id
    __typename
  }
}
''';

const String getSupplierNotifications = r'''
query get_notifications(
$user_id: uuid!
  $limit: Int!
  $offset: Int!) {
  notifications: dental_supplier_notifications(
    where: {dental_supplier_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    title
    type
    body
    payload
    image
    mark_as_read
    read_at
    status
    dental_supplier_id
    created_at
    updated_at
    __typename
}
}
''';

const String getPracticeNotifications = r'''
query get_notifications(
  $user_id: uuid!
  $limit: Int!
  $offset: Int!
  ) {
  notifications: dental_practice_notifications(
    where: {dental_practice_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    title
    type
    body
    payload
    image
    mark_as_read
    read_at
    status
    dental_practice_id
    created_at
    updated_at
    __typename
  }
}
''';

const String getAdminNotifications = r'''
query get_notifications(
  $user_id: uuid!
  $limit: Int!
  $offset: Int!
  ) {
  notifications: admin_user_notifications(
    where: {admin_user_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
    order_by: {created_at: desc}
    limit: $limit
    offset: $offset
  ) {
    id
    title
    type
    body
    payload
    image
    mark_as_read
    read_at
    status
    dental_professional_id
    created_at
    updated_at
    __typename
  }
}
''';
