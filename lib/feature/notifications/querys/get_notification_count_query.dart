const String professionNotificationCount = r'''
query get_notifications_aggregate($user_id: uuid!) {
  notifications_aggregate:dental_professional_notifications_aggregate(where: {
    dental_professional_id: {_eq: $user_id},
    mark_as_read: {_eq: false}
  }){
    aggregate {
      count
}
}
}
''';

const String supplierNotificationCount = r'''
query get_notifications_aggregate($user_id: uuid!) {
  notifications_aggregate: dental_supplier_notifications_aggregate(
    where: {dental_supplier_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
}
}
''';

const String practiceNotificationCount = r'''
query get_notifications_aggregate($user_id: uuid!) {
  notifications_aggregate: dental_practice_notifications_aggregate(
    where: {dental_practice_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
}
}
''';

const String adminNotificationCount = r'''
query get_notifications_aggregate($user_id: uuid!) {
  notifications_aggregate: admin_user_notifications_aggregate(
    where: {admin_user_id: {_eq: $user_id}, mark_as_read: {_eq: false}}
  ) {
    aggregate {
      count
      __typename
    }
    __typename
}
}
''';