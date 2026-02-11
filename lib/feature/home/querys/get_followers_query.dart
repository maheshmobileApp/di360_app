const String getFollowersQuery = r'''
query getFollowers($userId: uuid) {
  to_whome_i_am_following_aggregate: directory_followers_aggregate(
    where: {
      _or: [
        {dental_supplier_id: {_eq: $userId}},
        {dental_practice_id: {_eq: $userId}},
        {dental_professional_id: {_eq: $userId}},
        {dental_admin_id: {_eq: $userId}}
      ],
      following_status: {_eq: "APPROVED"}
    }
  ) {
    aggregate {
      count
    }
  }

  to_whome_i_am_following: directory_followers(
    where: {
      _or: [
        {dental_supplier_id: {_eq: $userId}},
        {dental_practice_id: {_eq: $userId}},
        {dental_professional_id: {_eq: $userId}},
        {dental_admin_id: {_eq: $userId}}
      ],
      following_status: {_eq: "APPROVED"}
    }
  ) {
    id
    following_status
    follower_dental_professional_id
    follower_dental_supplier_id
    follower_dental_practice_id
    follower_dental_professional {
      id
      name
      profile_image
      type
    }
    follower_dental_supplier {
      id
      name
      logo
      type
    }
    follower_dental_practice {
      id
      name
      logo
      type
    }
    dental_supplier { id name }
    dental_practice { id name }
    dental_professional { id name }
    dental_admin { id name }
  }

  who_is_following_aggregate: directory_followers_aggregate(
    where: {
      _or: [
        {follower_dental_supplier_id: {_eq: $userId}},
        {follower_dental_practice_id: {_eq: $userId}},
        {follower_dental_professional_id: {_eq: $userId}}
      ],
      following_status: {_eq: "APPROVED"}
    }
  ) {
    aggregate {
      count
    }
  }

  who_is_following: directory_followers(
    where: {
      _or: [
        {follower_dental_supplier_id: {_eq: $userId}},
        {follower_dental_practice_id: {_eq: $userId}},
        {follower_dental_professional_id: {_eq: $userId}}
      ],
      following_status: {_eq: "APPROVED"}
    }
  ) {
    id
    dental_admin_id
    dental_professional_id
    dental_practice_id
    dental_supplier_id
    following_status
    dental_supplier { id name }
    dental_practice { id name }
    dental_professional { id name }
    dental_admin { id name }
  }
}
''';